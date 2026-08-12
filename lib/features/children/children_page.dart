import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/children/child_form_page.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:nutritrack/l10n/app_localizations.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChildrenProvider>().loadChildren();
    });
  }

  Future<void> _openForm({ChildProfile? child}) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ChildFormPage(child: child)),
    );
    if (!mounted) return;
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            child == null ? l10n.childrenAddedMessage : l10n.childrenUpdatedMessage,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasChildren = context.watch<ChildrenProvider>().children.isNotEmpty;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(l10n.navChildren),
        actions: [
          if (hasChildren)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: _openForm,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add_rounded, size: 16, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        l10n.commonAdd,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Consumer<ChildrenProvider>(
        builder: (context, provider, _) {
          return RefreshIndicator(
            onRefresh: provider.loadChildren,
            color: AppTheme.primaryColor,
            child: _buildBody(provider, l10n),
          );
        },
      ),
    );
  }

  Widget _buildBody(ChildrenProvider provider, AppLocalizations l10n) {
    if (provider.isLoading && provider.children.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null && provider.children.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, size: 48, color: AppTheme.errorColor),
              const SizedBox(height: 16),
              Text(
                provider.error!,
                style: const TextStyle(color: AppTheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: provider.loadChildren,
                child: Text(l10n.commonRetry),
              ),
            ],
          ),
        ),
      );
    }

    final children = provider.children;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
      children: [
        if (provider.isLoading && children.isNotEmpty)
          const LinearProgressIndicator(
            backgroundColor: Colors.transparent,
          ),

        if (children.isEmpty)
          _buildEmptyState(l10n)
        else ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              l10n.childrenProfileCount(children.length),
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.child_care_rounded,
              size: 40,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.childrenNoneYetTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.childrenNoneYetSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openForm,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(l10n.childrenAddFirst),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(ChildProfile child) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.childrenDeleteTitle),
        content: Text(l10n.childrenDeleteConfirm(child.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      try {
        await context.read<ChildrenProvider>().deleteChild(child.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.childrenDeletedMessage(child.name))),
          );
        }
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.childrenDeleteFailed)),
          );
        }
      }
    }
  }
}

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
    final avatarColor = isFemale ? const Color(0xFFEC4899) : const Color(0xFF0EA5E9);
    final avatarBg = isFemale ? const Color(0xFFFDF2F8) : const Color(0xFFEFF6FF);
    final dob = child.dob.toLocal().toString().split(' ').first;

    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/child/details', arguments: child.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: avatarBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFemale ? Icons.girl_rounded : Icons.boy_rounded,
                size: 30,
                color: avatarColor,
              ),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _InfoChip(
                        label: child.gender,
                        color: avatarColor,
                      ),
                      const SizedBox(width: 6),
                      _InfoChip(
                        label: dob,
                        color: AppTheme.textSecondary,
                      ),
                    ],
                  ),
                  if (child.guardianName.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.childrenGuardianLabel(child.guardianName),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Actions
            Column(
              children: [
                _IconActionButton(
                  icon: Icons.edit_rounded,
                  onTap: onEdit,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(height: 6),
                _IconActionButton(
                  icon: Icons.delete_outline_rounded,
                  onTap: onDelete,
                  color: AppTheme.errorColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  const _IconActionButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
