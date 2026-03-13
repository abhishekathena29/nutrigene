import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About NutriGene')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Logo/Icon
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'NutriGene',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),

            // Mission Statement
            const Text(
              'Our Mission',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'NutriGene is an AI-powered nutrition tracker and assistant designed to combat child malnutrition through personalized nutrition recommendations, growth monitoring, and early intervention.',
                  style: TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Key Features
            const Text(
              'Key Features',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              'Growth Tracking',
              'Monitor children\'s growth using WHO standards',
              Icons.trending_up,
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildFeatureCard(
              'AI Recommendations',
              'Get personalized nutrition advice powered by AI',
              Icons.auto_awesome,
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildFeatureCard(
              'Epigenetic Risk Assessment',
              'Early detection of nutritional deficiencies',
              Icons.science,
              Colors.purple,
            ),
            const SizedBox(height: 8),
            _buildFeatureCard(
              'Brain Development',
              'Activities and nutrition tips for cognitive growth',
              Icons.psychology,
              Colors.orange,
            ),
            const SizedBox(height: 8),
            _buildFeatureCard(
              'NGO Support',
              'Tools for organizations managing multiple children',
              Icons.business,
              Colors.indigo,
            ),
            const SizedBox(height: 24),

            // Impact
            const Text(
              'Our Impact',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Together, we can end child malnutrition',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.public, color: Colors.green, size: 48),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'NutriGene is rapidly expanding its reach to help NGOs, caregivers, and health workers monitor child growth, combat malnutrition, and provide actionable AI insights worldwide.',
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Contact & Links
            const Text(
              'Get in Touch',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('support@nutrigene.org'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Website'),
                    subtitle: const Text('www.nutrigene.org'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text('Social Media'),
                    subtitle: const Text('Follow us on social platforms'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Copyright
            const Center(
              child: Text(
                '© 2025 NutriGene. All rights reserved.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Made with ❤️ for children worldwide',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    String title,
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
          ],
        ),
      ),
    );
  }
}
