import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Clearing all alerts...')),
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
              'Important notifications and reminders',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          _buildAlertCard(
            title: 'Nutritional Assessment Due',
            description:
                'Emma Johnson needs a nutritional assessment this week',
            time: '2 hours ago',
            icon: Icons.warning,
            color: Colors.orange,
            priority: 'High',
          ),
          const SizedBox(height: 12),
          _buildAlertCard(
            title: 'Low Iron Detected',
            description: 'Liam Smith showing signs of iron deficiency',
            time: '5 hours ago',
            icon: Icons.health_and_safety,
            color: Colors.red,
            priority: 'High',
          ),
          const SizedBox(height: 12),
          _buildAlertCard(
            title: 'Growth Milestone Reached',
            description:
                'Sophia Williams has reached expected growth milestone',
            time: '1 day ago',
            icon: Icons.celebration,
            color: Colors.green,
            priority: 'Low',
          ),
          const SizedBox(height: 12),
          _buildAlertCard(
            title: 'Meal Plan Update Available',
            description: 'New seasonal meal plans are now available',
            time: '2 days ago',
            icon: Icons.restaurant_menu,
            color: Colors.blue,
            priority: 'Medium',
          ),
          const SizedBox(height: 12),
          _buildAlertCard(
            title: 'Vaccination Reminder',
            description: 'Schedule vaccination for Noah Brown',
            time: '3 days ago',
            icon: Icons.medical_services,
            color: Colors.purple,
            priority: 'Medium',
          ),
          const SizedBox(height: 12),
          _buildAlertCard(
            title: 'Activity Recommendation',
            description: 'New brain development activities added',
            time: '4 days ago',
            icon: Icons.psychology,
            color: Colors.indigo,
            priority: 'Low',
          ),
          const SizedBox(height: 12),
          _buildAlertCard(
            title: 'Weight Monitoring',
            description: 'Time to track weight for Emma Johnson',
            time: '5 days ago',
            icon: Icons.monitor_weight,
            color: Colors.teal,
            priority: 'Medium',
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color color,
    required String priority,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(
                                priority,
                              ).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              priority,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getPriorityColor(priority),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Dismiss')),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

