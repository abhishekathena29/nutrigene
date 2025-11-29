import 'package:flutter/material.dart';

class SymptomsCheckerPage extends StatefulWidget {
  const SymptomsCheckerPage({super.key});

  @override
  State<SymptomsCheckerPage> createState() => _SymptomsCheckerPageState();
}

class _SymptomsCheckerPageState extends State<SymptomsCheckerPage> {
  final Set<String> _selectedSymptoms = {};
  bool _showResults = false;

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
    return Scaffold(
      appBar: AppBar(title: const Text('Symptoms Checker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Select symptoms to check for possible nutritional deficiencies',
                        style: TextStyle(color: Colors.blue),
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

            // Symptoms List
            ..._symptoms.entries.map(
              (entry) => _buildSymptomCheckbox(entry.key, entry.value),
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _selectedSymptoms.isEmpty
                  ? null
                  : () {
                      setState(() {
                        _showResults = true;
                      });
                    },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Check Deficiencies',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            // Results Section
            if (_showResults) ...[
              const SizedBox(height: 24),
              const Text(
                'Possible Deficiencies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.orange.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                      SizedBox(height: 12),
                      Text(
                        'Based on selected symptoms, possible deficiencies may include:',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildDeficiencyCard(
                'Iron Deficiency',
                'Common with fatigue, pale skin, and weakness',
                'Increase intake of red meat, spinach, lentils',
                Icons.bloodtype,
                Colors.red,
              ),
              const SizedBox(height: 8),
              _buildDeficiencyCard(
                'Vitamin D Deficiency',
                'Associated with muscle weakness and frequent infections',
                'Sun exposure, fortified milk, fish',
                Icons.wb_sunny,
                Colors.orange,
              ),
              const SizedBox(height: 8),
              _buildDeficiencyCard(
                'Vitamin A Deficiency',
                'Can cause night blindness and skin problems',
                'Carrots, sweet potatoes, dark leafy greens',
                Icons.visibility,
                Colors.deepOrange,
              ),
              const SizedBox(height: 8),
              _buildDeficiencyCard(
                'Protein Deficiency',
                'May result in delayed growth and hair loss',
                'Eggs, dairy, legumes, lean meat',
                Icons.egg,
                Colors.brown,
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.red.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.medical_services, color: Colors.red),
                          SizedBox(width: 12),
                          Text(
                            'Important Notice',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'This is a preliminary assessment tool. Please consult with a healthcare professional for proper diagnosis and treatment.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking appointment with nutritionist...'),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_today),
                label: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Consult a Nutritionist',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
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
            _showResults = false; // Reset results when symptoms change
          });
        },
        title: Text(symptom),
        secondary: Icon(icon, color: isSelected ? Colors.green : Colors.grey),
        activeColor: Colors.green,
      ),
    );
  }

  Widget _buildDeficiencyCard(
    String title,
    String description,
    String recommendation,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.recommend, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      recommendation,
                      style: const TextStyle(fontSize: 13, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

