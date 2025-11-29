import 'package:flutter/material.dart';

class BrainModulePage extends StatelessWidget {
  const BrainModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain & Development')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Support cognitive development through nutrition and activities',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          _buildMenuCard(
            context,
            icon: Icons.psychology,
            title: 'Brain Development Overview',
            description: 'Learn about brain development stages',
            color: Colors.purple,
            route: '/brain/overview',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.extension,
            title: 'Brain-Boosting Activities',
            description: 'Activities to enhance cognitive skills',
            color: Colors.blue,
            route: '/brain/activities',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.food_bank,
            title: 'Brain Nutrition Tips',
            description: 'Foods that support brain health',
            color: Colors.green,
            route: '/brain/nutrition-tips',
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
