import 'package:flutter/material.dart';
import 'package:nutritrack/features/children/child_form_page.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  @override
  void initState() {
    super.initState();
    // Fetch children once when the page is first shown.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChildrenProvider>().loadChildren();
    });
  }

  /// Opens the form. Pass [child] to edit, leave null to add new.
  Future<void> _openForm({ChildProfile? child}) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ChildFormPage(child: child)),
    );
    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            child == null ? 'Child has been added' : 'Child has been updated',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Children Profiles')),
      body: Consumer<ChildrenProvider>(
        builder: (context, provider, _) {
          return RefreshIndicator(
            onRefresh: provider.loadChildren,
            child: _buildBody(provider),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(ChildrenProvider provider) {
    // Show full-screen spinner only on the very first load.
    if (provider.isLoading && provider.children.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null && provider.children.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              provider.error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: provider.loadChildren,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final children = provider.children;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'Manage children profiles and track their growth',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),

        // Thin progress bar when refreshing while list is visible.
        if (provider.isLoading && children.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: LinearProgressIndicator(),
          ),

        // Empty state
        if (children.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.child_care, size: 48, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text(
                    'No children added yet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: _openForm,
                    icon: const Icon(Icons.add),
                    label: const Text('Add your first child'),
                  ),
                ],
              ),
            ),
          ),

        // Child cards
        for (final child in children)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ChildCard(
              child: child,
              onEdit: () => _openForm(child: child),
              onDelete: () => _confirmDelete(child),
            ),
          ),
      ],
    );
  }

  Future<void> _confirmDelete(ChildProfile child) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete profile?'),
        content: Text('Remove ${child.name} permanently?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      try {
        await context.read<ChildrenProvider>().deleteChild(child.id);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${child.name} deleted')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete. Try again.')),
          );
        }
      }
    }
  }
}

// ── Child card extracted into its own widget for clean separation ──────────

class _ChildCard extends StatelessWidget {
  const _ChildCard({
    required this.child,
    required this.onEdit,
    required this.onDelete,
  });

  final ChildProfile child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isFemale = child.gender.toLowerCase().startsWith('f');
    final color = isFemale ? Colors.pink : Colors.blue;

    return Card(
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, '/child/details', arguments: child.id),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(
                  isFemale ? Icons.girl : Icons.boy,
                  size: 30,
                  color: color,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'DOB: ${child.dob.toLocal().toString().split(' ').first}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    if (child.guardianName.isNotEmpty)
                      Text(
                        'Guardian: ${child.guardianName}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: onEdit,
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Colors.red,
                ),
                onPressed: onDelete,
                tooltip: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
