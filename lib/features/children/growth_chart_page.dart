import 'package:flutter/material.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class GrowthChartPage extends StatefulWidget {
  const GrowthChartPage({super.key});

  @override
  State<GrowthChartPage> createState() => _GrowthChartPageState();
}

class _GrowthChartPageState extends State<GrowthChartPage> {
  String? _childId;
  bool _loaded = false;

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
    if (_childId != null && !_loaded) {
      provider.loadGrowthRecords(_childId!);
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final childrenProvider = context.watch<ChildrenProvider>();
    final child = childrenProvider.getChildById(_childId);
    final records =
        _childId == null ? <GrowthRecord>[] : childrenProvider.getGrowthForChild(_childId!);

    return Scaffold(
      appBar: AppBar(title: const Text('Growth Charts')),
      body: child == null
          ? const Center(child: Text('Select a child to view growth trends.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.trending_up,
                              color: Colors.green, size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Growth for ${child.name}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Showing WHO growth measurements log',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _childId == null
                                ? null
                                : () => childrenProvider
                                    .loadGrowthRecords(_childId!),
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (records.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'No growth data yet',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/child/growth-input',
                                arguments: child.id,
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('Add measurement'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...records.map(
                      (record) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.withOpacity(0.2),
                            child: const Icon(Icons.monitor_weight,
                                color: Colors.blue),
                          ),
                          title: Text(
                            'Age ${record.ageInMonths.toStringAsFixed(1)} months',
                          ),
                          subtitle: Text(
                            'Wt ${record.weight}kg | Ht ${record.height}cm | MUAC ${record.muac}cm',
                          ),
                          trailing: Text(
                            record.date.toLocal().toString().split(' ').first,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
