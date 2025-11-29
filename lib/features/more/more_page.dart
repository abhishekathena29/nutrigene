import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Additional features and settings',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          _buildMenuCard(
            context,
            icon: Icons.business,
            title: 'NGO Dashboard',
            description: 'Manage multiple children profiles',
            color: Colors.indigo,
            route: '/ngo/dashboard',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.settings,
            title: 'Settings',
            description: 'App preferences and configurations',
            color: Colors.grey,
            route: '/settings',
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            icon: Icons.info,
            title: 'About NutriGene',
            description: 'Learn about the app and its mission',
            color: Colors.blue,
            route: '/about',
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & Support'),
          ),
          const ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
          ),
          const ListTile(
            leading: Icon(Icons.description),
            title: Text('Terms of Service'),
          ),
          const ListTile(
            leading: Icon(Icons.star),
            title: Text('Rate the App'),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
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

