import 'package:flutter/material.dart';

class BrainNutritionTipsPage extends StatelessWidget {
  const BrainNutritionTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain Nutrition Tips')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.green.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.food_bank, color: Colors.green, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feed the Brain',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Nutrition for optimal cognitive development',
                          style: TextStyle(color: Colors.green),
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
            'Essential Nutrients for Brain Health',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Omega-3 Fatty Acids',
            benefit: 'Critical for brain structure and cognitive function',
            sources: [
              'Fatty fish (salmon, mackerel)',
              'Walnuts',
              'Chia seeds',
              'Flaxseeds',
            ],
            icon: Icons.water_drop,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Iron',
            benefit:
                'Essential for oxygen transport and neurotransmitter production',
            sources: ['Red meat', 'Spinach', 'Lentils', 'Fortified cereals'],
            icon: Icons.bloodtype,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Protein',
            benefit: 'Building blocks for neurotransmitters and brain cells',
            sources: ['Eggs', 'Chicken', 'Beans', 'Greek yogurt', 'Nuts'],
            icon: Icons.egg,
            color: Colors.brown,
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Vitamin B Complex',
            benefit:
                'Supports energy production and neurotransmitter synthesis',
            sources: ['Whole grains', 'Eggs', 'Dark leafy greens', 'Legumes'],
            icon: Icons.energy_savings_leaf,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Choline',
            benefit: 'Important for memory and brain development',
            sources: ['Eggs', 'Beef liver', 'Soybeans', 'Chicken'],
            icon: Icons.psychology,
            color: Colors.purple,
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Zinc',
            benefit: 'Regulates neurotransmitter function and memory',
            sources: ['Oysters', 'Beef', 'Pumpkin seeds', 'Chickpeas'],
            icon: Icons.grain,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildNutrientCard(
            nutrient: 'Antioxidants',
            benefit: 'Protect brain cells from oxidative stress',
            sources: [
              'Berries',
              'Dark chocolate',
              'Green tea',
              'Colorful vegetables',
            ],
            icon: Icons.shield,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 24),

          const Text(
            'Brain-Boosting Meal Ideas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildMealIdeaCard(
            'Breakfast',
            'Oatmeal with berries, walnuts, and a drizzle of honey',
            Icons.wb_sunny,
            Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildMealIdeaCard(
            'Lunch',
            'Salmon with quinoa and steamed broccoli',
            Icons.lunch_dining,
            Colors.blue,
          ),
          const SizedBox(height: 8),
          _buildMealIdeaCard(
            'Snack',
            'Apple slices with almond butter',
            Icons.coffee,
            Colors.brown,
          ),
          const SizedBox(height: 8),
          _buildMealIdeaCard(
            'Dinner',
            'Whole grain pasta with spinach and chickpeas',
            Icons.dinner_dining,
            Colors.green,
          ),
          const SizedBox(height: 24),

          const Text(
            'Important Tips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTipRow(
                    'Stay hydrated - water is essential for brain function',
                  ),
                  const Divider(),
                  _buildTipRow(
                    'Eat regular meals to maintain stable blood sugar',
                  ),
                  const Divider(),
                  _buildTipRow('Limit processed foods and added sugars'),
                  const Divider(),
                  _buildTipRow(
                    'Include a variety of colorful fruits and vegetables',
                  ),
                  const Divider(),
                  _buildTipRow(
                    'Encourage family meals to support healthy eating habits',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Card(
            color: Colors.amber.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.amber),
                      SizedBox(width: 12),
                      Text(
                        'Remember',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'A balanced diet with variety is key to providing all the nutrients needed for optimal brain development. The earlier healthy eating habits are established, the better!',
                    style: TextStyle(color: Colors.brown, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientCard({
    required String nutrient,
    required String benefit,
    required List<String> sources,
    required IconData icon,
    required Color color,
  }) {
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
                    nutrient,
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
              benefit,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Food Sources:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ...sources.map(
                    (source) => Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 6, color: color),
                          const SizedBox(width: 8),
                          Text(source, style: const TextStyle(fontSize: 13)),
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

  Widget _buildMealIdeaCard(
    String mealType,
    String description,
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
                  Text(
                    mealType,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipRow(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(tip, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

