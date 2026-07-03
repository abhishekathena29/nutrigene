import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/children/child_form_page.dart';
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
    final provider = context.watch<ChildrenProvider>();
    final child = provider.getChildById(_childId);

    if (child == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isFemale = child.gender.toLowerCase().startsWith('f');
    final avatarColor = isFemale ? const Color(0xFFEC4899) : const Color(0xFF0EA5E9);
    final avatarBg = isFemale ? const Color(0xFFFDF2F8) : const Color(0xFFEFF6FF);
    final records = provider.getGrowthForChild(child.id);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // Custom hero app bar
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppTheme.backgroundColor,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppTheme.textPrimary),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChildFormPage(child: child)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.edit_rounded, size: 15, color: Colors.white),
                        SizedBox(width: 5),
                        Text('Edit', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [avatarBg, AppTheme.backgroundColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: avatarBg,
                        shape: BoxShape.circle,
                        border: Border.all(color: avatarColor.withValues(alpha: 0.3), width: 3),
                      ),
                      child: Icon(
                        isFemale ? Icons.girl_rounded : Icons.boy_rounded,
                        size: 46,
                        color: avatarColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      child.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _InfoPill(label: child.gender, color: avatarColor),
                        const SizedBox(width: 8),
                        _InfoPill(
                          label: 'DOB: ${child.dob.toLocal().toString().split(' ').first}',
                          color: AppTheme.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick actions grid
                _SectionTitle(title: 'Quick Actions'),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: [
                    _ActionCard(
                      icon: Icons.monitor_weight_outlined,
                      label: 'Growth Input',
                      color: const Color(0xFF10B981),
                      bgColor: const Color(0xFFECFDF5),
                      onTap: () => Navigator.pushNamed(context, '/child/growth-input', arguments: child.id),
                    ),
                    _ActionCard(
                      icon: Icons.insert_chart_outlined_rounded,
                      label: 'Growth Charts',
                      color: const Color(0xFF0EA5E9),
                      bgColor: const Color(0xFFEFF6FF),
                      onTap: () => Navigator.pushNamed(context, '/child/growth-chart', arguments: child.id),
                    ),
                    _ActionCard(
                      icon: Icons.science_outlined,
                      label: 'Epigenetic Risk',
                      color: const Color(0xFFF59E0B),
                      bgColor: const Color(0xFFFFFBEB),
                      onTap: () => Navigator.pushNamed(context, '/child/epigenetic', arguments: child.id),
                    ),
                    _ActionCard(
                      icon: Icons.description_outlined,
                      label: 'Reports',
                      color: const Color(0xFF6366F1),
                      bgColor: const Color(0xFFEEF2FF),
                      onTap: () => Navigator.pushNamed(context, '/child/report', arguments: child.id),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Profile info
                _SectionTitle(title: 'Profile Information'),
                const SizedBox(height: 14),
                _InfoCard(
                  rows: [
                    _InfoRow(label: 'Guardian', value: child.guardianName.isNotEmpty ? child.guardianName : '—'),
                    _InfoRow(label: 'Contact', value: child.contactNumber.isNotEmpty ? child.contactNumber : '—'),
                    _InfoRow(label: 'Notes', value: child.notes.isNotEmpty ? child.notes : '—'),
                  ],
                ),
                const SizedBox(height: 28),

                // Growth records
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SectionTitle(title: 'Growth Records'),
                    TextButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/child/growth-input', arguments: child.id),
                      icon: const Icon(Icons.add_rounded, size: 16),
                      label: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                if (records.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.bar_chart_rounded, size: 36, color: AppTheme.textTertiary),
                        const SizedBox(height: 10),
                        const Text(
                          'No growth data yet',
                          style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Add a measurement to start tracking.',
                          style: TextStyle(fontSize: 13, color: AppTheme.textTertiary),
                        ),
                      ],
                    ),
                  )
                else
                  ...records.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _GrowthRecordCard(record: entry.value, index: entry.key),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppTheme.textPrimary,
        letterSpacing: -0.3,
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});
  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final isLast = entry.key == rows.length - 1;
          final row = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        row.label,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        row.value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoRow {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;
}

class _GrowthRecordCard extends StatelessWidget {
  const _GrowthRecordCard({required this.record, required this.index});
  final GrowthRecord record;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Age: ${record.ageInMonths.toStringAsFixed(1)} months',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wt ${record.weight} kg · Ht ${record.height} cm · MUAC ${record.muac} cm',
                  style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          Text(
            record.date.toLocal().toString().split(' ').first,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
