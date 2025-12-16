import 'package:flutter/material.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class ChildDetailPage extends StatefulWidget {
  const ChildDetailPage({super.key});

  @override
  State<ChildDetailPage> createState() => _ChildDetailPageState();
}

class _ChildDetailPageState extends State<ChildDetailPage> {
  String? _childId;
  bool _loadedGrowth = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _childId ??= ModalRoute.of(context)?.settings.arguments as String?;
    final provider = context.read<ChildrenProvider>();
    if (provider.children.isEmpty) {
      provider.loadChildren();
    } else if (_childId == null && provider.children.isNotEmpty) {
      _childId = provider.children.first.id;
    }
    if (_childId != null && !_loadedGrowth) {
      provider.loadGrowthRecords(_childId!);
      _loadedGrowth = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final childrenProvider = context.watch<ChildrenProvider>();
    final child = childrenProvider.getChildById(_childId);

    return Scaffold(
      appBar: AppBar(
        title: Text(child?.name ?? 'Child Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: child == null
                ? null
                : () {
                    Navigator.pushNamed(
                      context,
                      '/child/form',
                      arguments: child,
                    );
                  },
          ),
        ],
      ),
      body: child == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.pink.withOpacity(0.2),
                          child: Icon(
                            child.gender.toLowerCase().startsWith('f')
                                ? Icons.girl
                                : Icons.boy,
                            size: 60,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          child.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${child.gender} • DOB: ${child.dob.toLocal().toString().split(' ').first}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/child/growth-input',
                                arguments: child.id,
                              ),
                            ),
                            _buildActionCard(
                              context,
                              icon: Icons.insert_chart,
                              title: 'Growth Charts',
                              color: Colors.blue,
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/child/growth-chart',
                                arguments: child.id,
                              ),
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
                        const Text(
                          'Recent Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildInfoRow(
                                  'Guardian',
                                  child.guardianName.isNotEmpty
                                      ? child.guardianName
                                      : '—',
                                ),
                                const Divider(),
                                _buildInfoRow(
                                  'Contact',
                                  child.contactNumber.isNotEmpty
                                      ? child.contactNumber
                                      : '—',
                                ),
                                const Divider(),
                                _buildInfoRow(
                                  'Notes',
                                  child.notes.isNotEmpty ? child.notes : '—',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Growth Records',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...childrenProvider
                            .getGrowthForChild(child.id)
                            .map(
                              (record) => Card(
                                child: ListTile(
                                  title: Text(
                                    'Age: ${record.ageInMonths.toStringAsFixed(1)} months',
                                  ),
                                  subtitle: Text(
                                    'Wt ${record.weight} kg, Ht ${record.height} cm, MUAC ${record.muac} cm',
                                  ),
                                  trailing: Text(
                                    record.date
                                        .toLocal()
                                        .toString()
                                        .split(' ')
                                        .first,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        if (childrenProvider.getGrowthForChild(child.id).isEmpty)
                          Card(
                            child: ListTile(
                              title: const Text('No growth data yet'),
                              subtitle: const Text(
                                'Add a new measurement to start tracking.',
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/child/growth-input',
                                    arguments: child.id,
                                  );
                                },
                                child: const Text('Add'),
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
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
