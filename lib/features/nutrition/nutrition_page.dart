import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Track meals, get personalized plans, and access recipes',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          _buildMenuCard(
            context,
            icon: Icons.shopping_basket,
            title: 'Food Access & Affordability',
            description: 'Check food availability and pricing',
            color: Colors.green,
            route: '/nutrition/access',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.restaurant_menu,
            title: 'Meal Plans',
            description: 'Daily and weekly meal suggestions',
            color: Colors.orange,
            route: '/nutrition/meal-plan',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.menu_book,
            title: 'Recipes',
            description: 'Nutritious recipes for children',
            color: Colors.blue,
            route: '/nutrition/recipes',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.health_and_safety,
            title: 'Symptoms Checker',
            description: 'Check for nutritional deficiencies',
            color: Colors.red,
            route: '/nutrition/symptoms',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String route,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color, size: 28),
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
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

