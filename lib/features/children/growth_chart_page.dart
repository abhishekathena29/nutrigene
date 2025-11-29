import 'package:flutter/material.dart';

class GrowthChartPage extends StatelessWidget {
  const GrowthChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Growth Charts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.green, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WHO Growth Standards',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Charts based on WHO child growth standards',
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

            // Chart Type Selector
            const Text(
              'Select Chart Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildChartTypeCard(
              context,
              title: 'Weight-for-Age',
              description: 'Track weight against WHO standards',
              icon: Icons.monitor_weight,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildChartTypeCard(
              context,
              title: 'Height-for-Age',
              description: 'Track height against WHO standards',
              icon: Icons.height,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildChartTypeCard(
              context,
              title: 'Weight-for-Height',
              description: 'BMI indicator for children',
              icon: Icons.balance,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildChartTypeCard(
              context,
              title: 'BMI-for-Age',
              description: 'Body Mass Index trends',
              icon: Icons.straighten,
              color: Colors.purple,
            ),
            const SizedBox(height: 24),

            // Placeholder for chart
            Card(
              child: Container(
                height: 300,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insert_chart,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Growth charts (WHO) will go here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select a chart type above to view',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartTypeCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Loading $title chart...')));
        },
        borderRadius: BorderRadius.circular(12),
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
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

