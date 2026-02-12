import 'package:flutter/material.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  bool _didLoad = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_didLoad && mounted) {
        context.read<ChildrenProvider>().loadChildren();
        _didLoad = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final childrenProvider = context.watch<ChildrenProvider>();

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
          if (childrenProvider.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (childrenProvider.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                childrenProvider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ...childrenProvider.children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildChildCard(context, child),
            ),
          ),
          if (!childrenProvider.isLoading &&
              childrenProvider.children.isEmpty &&
              childrenProvider.error == null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'No children added yet',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/child/form'),
                      icon: const Icon(Icons.add),
                      label: const Text('Create your first profile'),
                    ),
                  ],
                ),
              ),
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
    BuildContext context,
    ChildProfile child,
  ) {
    final Color color =
        child.gender.toLowerCase().startsWith('f') ? Colors.pink : Colors.blue;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/child/details',
            arguments: child.id,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(
                  child.gender.toLowerCase().startsWith('f')
                      ? Icons.girl
                      : Icons.boy,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'DOB: ${child.dob.toLocal().toString().split(' ').first}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      child.guardianName.isNotEmpty
                          ? 'Guardian: ${child.guardianName}'
                          : 'Tap to view details',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/child/form',
                    arguments: child,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete profile?'),
                      content: Text('Remove ${child.name} permanently?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await context.read<ChildrenProvider>().deleteChild(child.id);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${child.name} deleted')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
