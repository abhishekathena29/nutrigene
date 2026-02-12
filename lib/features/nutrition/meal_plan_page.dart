import 'package:flutter/material.dart';
import 'package:nutritrack/features/nutrition/provider/nutrition_provider.dart';
import 'package:provider/provider.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  String _selectedDay = 'Monday';
  bool _didLoad = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_didLoad && mounted) {
        context.read<NutritionProvider>().loadMealPlans();
        _didLoad = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NutritionProvider>();
    final mealPlan = provider.mealPlans[_selectedDay];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plans'),
        actions: [
          IconButton(
            onPressed: provider.mealPlans[_selectedDay] == null
                ? null
                : () => _confirmDeletePlan(context),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.green.shade50,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.restaurant_menu, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personalized meal plans for optimal nutrition',
                          style: TextStyle(color: Colors.green),
                        ),
                        if (provider.aiError != null)
                          Text(
                            provider.aiError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: provider.loadingPlans
                        ? null
                        : () => provider.loadMealPlans(),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday',
                ].map((day) => _buildDayChip(day)).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meal Plan for $_selectedDay',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (mealPlan != null && mealPlan.meals.isNotEmpty) ...[
                    _buildMealCard(
                      'Breakfast',
                      mealPlan.meals['Breakfast'] ?? '',
                      '7:00 AM',
                      Icons.wb_sunny,
                      Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Mid-Morning Snack',
                      mealPlan.meals['Mid-Morning'] ?? '',
                      '10:00 AM',
                      Icons.coffee,
                      Colors.brown,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Lunch',
                      mealPlan.meals['Lunch'] ?? '',
                      '12:30 PM',
                      Icons.lunch_dining,
                      Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Afternoon Snack',
                      mealPlan.meals['Afternoon'] ?? '',
                      '3:30 PM',
                      Icons.icecream,
                      Colors.pink,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Dinner',
                      mealPlan.meals['Dinner'] ?? '',
                      '7:00 PM',
                      Icons.dinner_dining,
                      Colors.blue,
                    ),
                    if (mealPlan.aiNote != null &&
                        mealPlan.aiNote!.trim().isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Card(
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            mealPlan.aiNote!,
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ],
                  ] else
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            const Text(
                              'No meal plan saved yet',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: provider.aiBusy
                                  ? null
                                  : () => _promptForGeneration(context),
                              icon: const Icon(Icons.auto_awesome),
                              label: const Text('Generate with AI'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lightbulb, color: Colors.blue),
                              SizedBox(width: 12),
                              Text(
                                'Nutrition Tip',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            mealPlan?.aiNote ??
                                'Include a variety of colors in meals to ensure diverse nutrients.',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            provider.aiBusy ? null : () => _promptForGeneration(context),
        icon: provider.aiBusy
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.auto_awesome),
        label: const Text('Generate Custom Plan'),
      ),
    );
  }

  Future<void> _promptForGeneration(BuildContext context) async {
    final preferencesController = TextEditingController();
    final ageController = TextEditingController(text: '5 years');
    final provider = context.read<NutritionProvider>();
    final shouldGenerate = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Personalize with Gemini'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Child age',
                hintText: 'e.g. 5 years',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: preferencesController,
              decoration: const InputDecoration(
                labelText: 'Preferences or restrictions',
                hintText: 'e.g. vegetarian, no nuts',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Generate'),
          ),
        ],
      ),
    );

    if (shouldGenerate == true) {
      final plan = await provider.generatePlan(
        day: _selectedDay,
        childAge: ageController.text,
        preferences: preferencesController.text.isEmpty
            ? null
            : preferencesController.text,
      );
      if (plan != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Meal plan saved')),
        );
      }
    }
  }

  Widget _buildDayChip(String day) {
    final bool isSelected = day == _selectedDay;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(day),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedDay = day;
            });
          }
        },
        selectedColor: Theme.of(context).colorScheme.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildMealCard(
    String mealType,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        mealType,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description.isNotEmpty
                        ? description
                        : 'Tap edit to add a meal',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => _editMeal(mealType, description),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editMeal(String mealType, String existing) async {
    final provider = context.read<NutritionProvider>();
    final controller = TextEditingController(text: existing);
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $mealType'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Meal description',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (shouldSave == true) {
      final current = provider.mealPlans[_selectedDay];
      final updatedMeals = Map<String, String>.from(
        current?.meals ??
            {
              'Breakfast': '',
              'Mid-Morning': '',
              'Lunch': '',
              'Afternoon': '',
              'Dinner': '',
            },
      );
      updatedMeals[mealType] = controller.text.trim();
      await provider.saveMealPlan(
        MealPlan(day: _selectedDay, meals: updatedMeals, aiNote: current?.aiNote),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$mealType updated')),
        );
      }
    }
  }

  Future<void> _confirmDeletePlan(BuildContext context) async {
    final provider = context.read<NutritionProvider>();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete meal plan?'),
        content: Text('Remove meal plan for $_selectedDay?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await provider.deleteMealPlan(_selectedDay);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Meal plan deleted')),
        );
      }
    }
  }
}
