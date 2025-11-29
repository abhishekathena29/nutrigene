import 'package:flutter/material.dart';

class NgoDashboardPage extends StatelessWidget {
  const NgoDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/child/form');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // NGO Info Card
            Card(
              color: Colors.indigo.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business, color: Colors.indigo, size: 32),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hope Foundation',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Managing 45 children across 3 locations',
                                style: TextStyle(color: Colors.indigo),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Statistics
            const Text(
              'Overview Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Children',
                    '45',
                    Icons.child_care,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Active Cases',
                    '12',
                    Icons.warning,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Well Nourished',
                    '38',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'At Risk',
                    '7',
                    Icons.error,
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Children List
            const Text(
              'Children Profiles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildChildListItem(
              context,
              name: 'Emma Johnson',
              age: '5 years',
              status: 'Well Nourished',
              statusColor: Colors.green,
              location: 'Center A',
            ),
            const SizedBox(height: 8),
            _buildChildListItem(
              context,
              name: 'Liam Smith',
              age: '3 years',
              status: 'Needs Attention',
              statusColor: Colors.orange,
              location: 'Center A',
            ),
            const SizedBox(height: 8),
            _buildChildListItem(
              context,
              name: 'Sophia Williams',
              age: '7 years',
              status: 'Well Nourished',
              statusColor: Colors.green,
              location: 'Center B',
            ),
            const SizedBox(height: 8),
            _buildChildListItem(
              context,
              name: 'Noah Brown',
              age: '4 years',
              status: 'At Risk',
              statusColor: Colors.red,
              location: 'Center A',
            ),
            const SizedBox(height: 8),
            _buildChildListItem(
              context,
              name: 'Olivia Davis',
              age: '6 years',
              status: 'Well Nourished',
              statusColor: Colors.green,
              location: 'Center C',
            ),
            const SizedBox(height: 24),

            // Action Buttons
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating bulk report...')),
                );
              },
              icon: const Icon(Icons.description),
              label: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Generate Bulk Report',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exporting data...')),
                );
              },
              icon: const Icon(Icons.download),
              label: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Export Data', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildListItem(
    BuildContext context, {
    required String name,
    required String age,
    required String status,
    required Color statusColor,
    required String location,
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
              const CircleAvatar(radius: 25, child: Icon(Icons.child_care)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$age • $location',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
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

