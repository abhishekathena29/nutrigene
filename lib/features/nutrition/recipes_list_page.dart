import 'package:flutter/material.dart';

class RecipesListPage extends StatelessWidget {
  const RecipesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search recipes...')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Nutritious recipes designed for children',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          _buildRecipeCard(
            context,
            title: 'Vegetable Rice Bowl',
            description: 'Colorful rice bowl with mixed vegetables',
            prepTime: '25 min',
            difficulty: 'Easy',
            calories: '320 kcal',
            image: Icons.rice_bowl,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            context,
            title: 'Banana Oat Pancakes',
            description: 'Healthy pancakes made with banana and oats',
            prepTime: '15 min',
            difficulty: 'Easy',
            calories: '250 kcal',
            image: Icons.breakfast_dining,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            context,
            title: 'Chicken Veggie Soup',
            description: 'Warm soup packed with protein and vegetables',
            prepTime: '40 min',
            difficulty: 'Medium',
            calories: '280 kcal',
            image: Icons.soup_kitchen,
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            context,
            title: 'Spinach & Cheese Quesadilla',
            description: 'Kid-friendly quesadilla with hidden spinach',
            prepTime: '20 min',
            difficulty: 'Easy',
            calories: '310 kcal',
            image: Icons.lunch_dining,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            context,
            title: 'Fruit Smoothie Bowl',
            description: 'Refreshing smoothie bowl topped with fruits',
            prepTime: '10 min',
            difficulty: 'Easy',
            calories: '220 kcal',
            image: Icons.icecream,
            color: Colors.pink,
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            context,
            title: 'Lentil Dal with Rice',
            description: 'Traditional dal rich in protein and iron',
            prepTime: '35 min',
            difficulty: 'Medium',
            calories: '340 kcal',
            image: Icons.set_meal,
            color: Colors.brown,
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            context,
            title: 'Sweet Potato Fries',
            description: 'Baked sweet potato fries - healthy snack',
            prepTime: '30 min',
            difficulty: 'Easy',
            calories: '180 kcal',
            image: Icons.fastfood,
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(
    BuildContext context, {
    required String title,
    required String description,
    required String prepTime,
    required String difficulty,
    required String calories,
    required IconData image,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/nutrition/recipe');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(image, color: color, size: 35),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          prepTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.local_fire_department,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          calories,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      difficulty,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

