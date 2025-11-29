import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to favorites!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing recipe...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Recipe Header
            Container(
              height: 200,
              color: Colors.green.withOpacity(0.2),
              child: const Center(
                child: Icon(Icons.rice_bowl, size: 100, color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vegetable Rice Bowl',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A colorful and nutritious rice bowl packed with vegetables, perfect for growing children',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Recipe Stats
                  Row(
                    children: [
                      _buildStatChip(Icons.schedule, '25 min', Colors.blue),
                      const SizedBox(width: 8),
                      _buildStatChip(
                        Icons.local_fire_department,
                        '320 kcal',
                        Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      _buildStatChip(Icons.person, '2 servings', Colors.green),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Nutritional Information
                  const Text(
                    'Nutritional Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildNutrientRow('Protein', '12g', Colors.red),
                          const Divider(),
                          _buildNutrientRow('Carbs', '45g', Colors.orange),
                          const Divider(),
                          _buildNutrientRow('Fat', '8g', Colors.yellow),
                          const Divider(),
                          _buildNutrientRow('Fiber', '6g', Colors.green),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Ingredients
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• 1 cup white or brown rice'),
                          SizedBox(height: 8),
                          Text(
                            '• 1 cup mixed vegetables (carrots, peas, corn)',
                          ),
                          SizedBox(height: 8),
                          Text('• 1 small onion, chopped'),
                          SizedBox(height: 8),
                          Text('• 2 cloves garlic, minced'),
                          SizedBox(height: 8),
                          Text('• 2 tablespoons olive oil'),
                          SizedBox(height: 8),
                          Text('• Salt and pepper to taste'),
                          SizedBox(height: 8),
                          Text('• Fresh herbs (optional)'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Instructions
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildInstructionCard(
                    '1',
                    'Cook rice according to package instructions. Set aside.',
                  ),
                  const SizedBox(height: 8),
                  _buildInstructionCard(
                    '2',
                    'Heat olive oil in a large pan over medium heat.',
                  ),
                  const SizedBox(height: 8),
                  _buildInstructionCard(
                    '3',
                    'Sauté onion and garlic until fragrant, about 2-3 minutes.',
                  ),
                  const SizedBox(height: 8),
                  _buildInstructionCard(
                    '4',
                    'Add mixed vegetables and cook until tender, about 5-7 minutes.',
                  ),
                  const SizedBox(height: 8),
                  _buildInstructionCard(
                    '5',
                    'Add cooked rice to the pan and mix well with vegetables.',
                  ),
                  const SizedBox(height: 8),
                  _buildInstructionCard(
                    '6',
                    'Season with salt and pepper. Cook for another 2-3 minutes.',
                  ),
                  const SizedBox(height: 8),
                  _buildInstructionCard(
                    '7',
                    'Garnish with fresh herbs if desired and serve warm.',
                  ),
                  const SizedBox(height: 24),

                  // Tips
                  Card(
                    color: Colors.blue.shade50,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lightbulb, color: Colors.blue),
                              SizedBox(width: 12),
                              Text(
                                'Chef\'s Tips',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            '• Use brown rice for extra fiber\n'
                            '• Add protein like tofu or chicken for a complete meal\n'
                            '• Freeze individual portions for quick meals',
                            style: TextStyle(color: Colors.blue),
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
    );
  }

  Widget _buildStatChip(IconData icon, String label, Color color) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
    );
  }

  Widget _buildNutrientRow(String nutrient, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Text(nutrient, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text(
            amount,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard(String step, String instruction) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green.withOpacity(0.2),
              child: Text(
                step,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(instruction, style: const TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}

