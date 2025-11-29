import 'package:flutter/material.dart';

class ChildrenPage extends StatelessWidget {
  const ChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Children Profiles')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Manage children profiles and track their growth',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          _buildChildCard(
            context,
            name: 'Emma Johnson',
            age: '5 years',
            lastUpdate: '2 days ago',
            imageIcon: Icons.girl,
            color: Colors.pink,
          ),
          const SizedBox(height: 12),
          _buildChildCard(
            context,
            name: 'Liam Smith',
            age: '3 years',
            lastUpdate: '1 week ago',
            imageIcon: Icons.boy,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildChildCard(
            context,
            name: 'Sophia Williams',
            age: '7 years',
            lastUpdate: '3 days ago',
            imageIcon: Icons.girl,
            color: Colors.purple,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/child/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChildCard(
    BuildContext context, {
    required String name,
    required String age,
    required String lastUpdate,
    required IconData imageIcon,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/child/details');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(imageIcon, size: 32, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      age,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Updated: $lastUpdate',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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

