import 'package:flutter/material.dart';

class ChildDetailPage extends StatelessWidget {
  const ChildDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/child/form');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Card
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.pink.withOpacity(0.2),
                    child: const Icon(Icons.girl, size: 60, color: Colors.pink),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Emma Johnson',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '5 years old • Female',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Quick Actions Grid
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildActionCard(
                        context,
                        icon: Icons.height,
                        title: 'Growth Input',
                        color: Colors.green,
                        onTap: () =>
                            Navigator.pushNamed(context, '/child/growth-input'),
                      ),
                      _buildActionCard(
                        context,
                        icon: Icons.insert_chart,
                        title: 'Growth Charts',
                        color: Colors.blue,
                        onTap: () =>
                            Navigator.pushNamed(context, '/child/growth-chart'),
                      ),
                      _buildActionCard(
                        context,
                        icon: Icons.science,
                        title: 'Epigenetic Risk',
                        color: Colors.orange,
                        onTap: () =>
                            Navigator.pushNamed(context, '/child/epigenetic'),
                      ),
                      _buildActionCard(
                        context,
                        icon: Icons.description,
                        title: 'Reports',
                        color: Colors.purple,
                        onTap: () =>
                            Navigator.pushNamed(context, '/child/report'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Recent Information
                  const Text(
                    'Recent Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildInfoRow('Weight', '18.5 kg'),
                          const Divider(),
                          _buildInfoRow('Height', '110 cm'),
                          const Divider(),
                          _buildInfoRow('MUAC', '16.5 cm'),
                          const Divider(),
                          _buildInfoRow('Last Check', '2 days ago'),
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

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

