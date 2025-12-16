import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MealPlan {
  MealPlan({
    required this.day,
    required this.meals,
    this.aiNote,
  });

  final String day;
  final Map<String, String> meals;
  final String? aiNote;

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'meals': meals,
      'aiNote': aiNote,
    };
  }

  static MealPlan fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final Map<String, String> meals =
        (data['meals'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(key, value.toString()),
            ) ??
            {};
    return MealPlan(
      day: data['day'] as String? ?? doc.id,
      meals: meals,
      aiNote: data['aiNote'] as String?,
    );
  }
}

class NutritionProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _geminiApiKey =
      const String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

  Map<String, MealPlan> _mealPlans = {};
  bool _loadingPlans = false;
  bool _aiBusy = false;
  String? _aiError;
  String? _symptomAnalysis;

  Map<String, MealPlan> get mealPlans => _mealPlans;
  bool get loadingPlans => _loadingPlans;
  bool get aiBusy => _aiBusy;
  String? get aiError => _aiError;
  String? get symptomAnalysis => _symptomAnalysis;

  Future<void> loadMealPlans() async {
    _loadingPlans = true;
    notifyListeners();
    try {
      final snapshot =
          await _firestore.collection('mealPlans').orderBy('day').get();
      _mealPlans = {
        for (final doc in snapshot.docs) doc.id: MealPlan.fromDoc(doc),
      };
    } finally {
      _loadingPlans = false;
      notifyListeners();
    }
  }

  Future<void> saveMealPlan(MealPlan plan) async {
    await _firestore.collection('mealPlans').doc(plan.day).set(plan.toMap());
    _mealPlans = {
      ..._mealPlans,
      plan.day: plan,
    };
    notifyListeners();
  }

  Future<void> deleteMealPlan(String day) async {
    await _firestore.collection('mealPlans').doc(day).delete();
    _mealPlans.remove(day);
    notifyListeners();
  }

  Future<MealPlan?> generatePlan({
    required String day,
    required String childAge,
    String? preferences,
  }) async {
    if (_geminiApiKey.isEmpty) {
      _aiError = 'Gemini API key is missing. Set GEMINI_API_KEY.';
      notifyListeners();
      return null;
    }

    _aiBusy = true;
    _aiError = null;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _geminiApiKey,
      );
      final prompt =
          'Create a simple meal plan for a child aged $childAge for $day. '
          'Return JSON with keys breakfast, midMorning, lunch, afternoon, dinner, snackNote. '
          'Keep meals short and local-friendly. '
          'Preferences or restrictions: ${preferences ?? 'none'}.';
      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text ?? '';

      Map<String, String>? parsedMeals = _safeParseMeals(text);
      if (parsedMeals == null || parsedMeals.isEmpty) {
        _aiError = 'Could not parse AI response, showing the raw note.';
        notifyListeners();
        final fallbackPlan = MealPlan(
          day: day,
          meals: _mealPlans[day]?.meals ?? {},
          aiNote: text,
        );
        await saveMealPlan(fallbackPlan);
        _aiBusy = false;
        notifyListeners();
        return fallbackPlan;
      }

      final plan = MealPlan(
        day: day,
        meals: {
          'Breakfast': parsedMeals['breakfast'] ?? '',
          'Mid-Morning': parsedMeals['midMorning'] ?? '',
          'Lunch': parsedMeals['lunch'] ?? '',
          'Afternoon': parsedMeals['afternoon'] ?? '',
          'Dinner': parsedMeals['dinner'] ?? '',
        },
        aiNote: parsedMeals['snackNote'],
      );
      await saveMealPlan(plan);
      _aiBusy = false;
      notifyListeners();
      return plan;
    } catch (e) {
      _aiError = 'AI request failed: $e';
      _aiBusy = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> analyzeSymptoms(List<String> symptoms) async {
    if (_geminiApiKey.isEmpty) {
      _aiError = 'Gemini API key is missing. Set GEMINI_API_KEY.';
      notifyListeners();
      return;
    }
    _aiBusy = true;
    _aiError = null;
    notifyListeners();
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _geminiApiKey,
      );
      final prompt = '''
You are a pediatric nutrition assistant. Based on these symptoms: ${symptoms.join(', ')}
List 2-3 possible nutrient deficiencies and a short food-first recommendation for each. Keep it under 120 words.
''';
      final response = await model.generateContent([Content.text(prompt)]);
      _symptomAnalysis = response.text ?? 'No analysis available right now.';
    } catch (e) {
      _aiError = 'Symptom analysis failed: $e';
    } finally {
      _aiBusy = false;
      notifyListeners();
    }
  }

  Map<String, String>? _safeParseMeals(String raw) {
    try {
      final cleaned = raw.trim().replaceAll('```json', '').replaceAll('```', '');
      final Map<String, dynamic> decoded = jsonDecode(cleaned);
      return decoded.map((key, value) => MapEntry(key, value.toString()));
    } catch (_) {
      return null;
    }
  }
}
