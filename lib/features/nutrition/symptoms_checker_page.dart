import 'package:flutter/material.dart';
import 'package:nutritrack/features/nutrition/provider/nutrition_provider.dart';
import 'package:provider/provider.dart';

class SymptomsCheckerPage extends StatefulWidget {
  const SymptomsCheckerPage({super.key});

  @override
  State<SymptomsCheckerPage> createState() => _SymptomsCheckerPageState();
}

class _SymptomsCheckerPageState extends State<SymptomsCheckerPage> {
  final Set<String> _selectedSymptoms = {};

  final Map<String, IconData> _symptoms = {
    'Fatigue or weakness': Icons.bedtime,
    'Pale skin': Icons.face,
    'Hair loss': Icons.self_improvement,
    'Brittle nails': Icons.pan_tool,
    'Poor appetite': Icons.no_meals,
    'Delayed growth': Icons.child_care,
    'Frequent infections': Icons.sick,
    'Poor concentration': Icons.psychology,
    'Muscle weakness': Icons.fitness_center,
    'Night blindness': Icons.dark_mode,
    'Skin problems': Icons.healing,
    'Slow wound healing': Icons.healing,
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NutritionProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Symptoms Checker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.info, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select symptoms to check for possible nutritional deficiencies',
                            style: TextStyle(color: Colors.blue),
                          ),
                          if (provider.aiError != null)
                            Text(
                              provider.aiError!,
                              style: const TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Symptoms',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._symptoms.entries.map(
              (entry) => _buildSymptomCheckbox(entry.key, entry.value),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _selectedSymptoms.isEmpty || provider.aiBusy
                  ? null
                  : () async {
                      await provider.analyzeSymptoms(_selectedSymptoms.toList());
                    },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: provider.aiBusy
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Check Deficiencies',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            if (provider.symptomAnalysis != null &&
                provider.symptomAnalysis!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Card(
                  color: Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.warning, color: Colors.orange),
                            SizedBox(width: 12),
                            Text(
                              'Assessment Results',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          provider.symptomAnalysis!,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomCheckbox(String symptom, IconData icon) {
    final bool isSelected = _selectedSymptoms.contains(symptom);
    return Card(
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _selectedSymptoms.add(symptom);
            } else {
              _selectedSymptoms.remove(symptom);
            }
          });
        },
        title: Text(symptom),
        secondary: Icon(icon, color: isSelected ? Colors.green : Colors.grey),
        activeColor: Colors.green,
      ),
    );
  }
}
