import 'package:flutter/material.dart';

class CaregiverReportPage extends StatelessWidget {
  const CaregiverReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiver Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing report...')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading report...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Child Info Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.pink.withOpacity(0.2),
                      child: const Icon(
                        Icons.girl,
                        size: 36,
                        color: Colors.pink,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emma Johnson',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '5 years old • Female',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Report Date
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.blue),
                    SizedBox(width: 12),
                    Text(
                      'Report Generated: November 22, 2025',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Summary Section
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Emma is showing healthy growth patterns with consistent weight and height gains. Nutritional intake is adequate with room for improvement in micronutrient diversity. Development milestones are being met appropriately for her age group.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Growth Metrics
            const Text(
              'Growth Metrics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildMetricRow('Current Weight', '18.5 kg', Colors.green),
                    const Divider(),
                    _buildMetricRow('Current Height', '110 cm', Colors.green),
                    const Divider(),
                    _buildMetricRow('BMI', '15.3', Colors.green),
                    const Divider(),
                    _buildMetricRow('Weight Percentile', '60th', Colors.green),
                    const Divider(),
                    _buildMetricRow('Height Percentile', '55th', Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nutrition Status
            const Text(
              'Nutrition Status',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildStatusCard(
              title: 'Overall Nutrition',
              status: 'Good',
              description: 'Meeting daily nutritional requirements',
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            _buildStatusCard(
              title: 'Micronutrients',
              status: 'Needs Attention',
              description: 'Consider increasing iron and vitamin D',
              color: Colors.orange,
            ),
            const SizedBox(height: 24),

            // Recommendations
            const Text(
              'Recommendations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Continue current feeding schedule',
                      style: TextStyle(fontSize: 16, height: 1.8),
                    ),
                    Text(
                      '• Increase variety of green vegetables',
                      style: TextStyle(fontSize: 16, height: 1.8),
                    ),
                    Text(
                      '• Add iron-rich foods to diet',
                      style: TextStyle(fontSize: 16, height: 1.8),
                    ),
                    Text(
                      '• Ensure adequate vitamin D exposure',
                      style: TextStyle(fontSize: 16, height: 1.8),
                    ),
                    Text(
                      '• Schedule follow-up in 3 months',
                      style: TextStyle(fontSize: 16, height: 1.8),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading PDF report...')),
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Download PDF Report',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scheduling appointment...')),
                );
              },
              icon: const Icon(Icons.calendar_today),
              label: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Schedule Follow-up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.check_circle, color: color, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String status,
    required String description,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(Icons.info, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                    ],
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

