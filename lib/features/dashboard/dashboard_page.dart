import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text('NutriGene'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroCard(context),
            const SizedBox(height: 24),
            _SectionTitle(
              title: 'Today’s Snapshot',
              action: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/alerts'),
                child: const Text('View alerts'),
              ),
            ),
            const SizedBox(height: 12),
            _buildSnapshotTiles(context),
            const SizedBox(height: 12),
            _buildTodayMealsCard(context),
            const SizedBox(height: 28),
            const _SectionTitle(title: 'Key Alerts'),
            const SizedBox(height: 12),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('alerts')
                  .orderBy('timestamp', descending: true)
                  .limit(2)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green.shade400),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'You\'re all caught up! No recent key alerts.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    
                    IconData iconData = Icons.notifications;
                    String type = data['type'] ?? '';
                    if (type == 'health') iconData = Icons.health_and_safety;
                    if (type == 'nutrition') iconData = Icons.restaurant_menu;
                    if (type == 'growth') iconData = Icons.celebration;
                    if (type == 'warning') iconData = Icons.warning;
                    if (type == 'activity') iconData = Icons.psychology;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildAlertCard(
                        context,
                        icon: iconData,
                        title: data['title'] ?? 'Alert',
                        subtitle: data['description'] ?? '',
                        chipLabel: data['priority'] ?? 'Low',
                        onTap: () => Navigator.pushNamed(context, '/alerts'),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            const _SectionTitle(title: 'Quick Actions'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildActionPill(
                  context,
                  icon: Icons.restaurant_menu,
                  label: 'Meal plans',
                  onTap: () =>
                      Navigator.pushNamed(context, '/nutrition/meal-plan'),
                ),
                _buildActionPill(
                  context,
                  icon: Icons.psychology_alt_outlined,
                  label: 'Brain tips',
                  onTap: () =>
                      Navigator.pushNamed(context, '/brain/nutrition-tips'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA778), Color(0xFF0EA5E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Welcome back, NutriGuardian',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, '/nutrition/meal-plan'),
            icon: const Icon(Icons.local_florist, size: 18),
            label: const Text('Today\'s focus'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'AI-curated nutrition and growth insights are ready. Let\'s keep your little ones thriving.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildHeroBadgeStream(
                icon: Icons.health_and_safety,
                label: 'Wellness logged',
                collection: 'wellnessLogs',
              ),
              const SizedBox(width: 10),
              _buildHeroBadgeStream(
                icon: Icons.local_dining,
                label: 'Meals planned',
                collection: 'mealPlans',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSnapshotTiles(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: tileWidth,
              child: _buildSnapshotTileStream(
                context,
                icon: Icons.child_care,
                label: 'Children',
                collection: 'children',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              width: tileWidth,
              child: _buildSnapshotTileStream(
                context,
                icon: Icons.restaurant_menu,
                label: 'Meals',
                collection: 'mealPlans',
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              width: tileWidth,
              child: _buildSnapshotTileStream(
                context,
                icon: Icons.psychology,
                label: 'Activities',
                collection: 'activities',
                color: Colors.indigo.shade400,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSnapshotTileStream(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String collection,
    required Color color,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Failed to load $collection: ${snapshot.error}');
        }
        final value = snapshot.hasData ? snapshot.data!.size.toString() : '--';
        return _buildSnapshotTile(
          context,
          icon: icon,
          label: label,
          value: value,
          color: color,
        );
      },
    );
  }

  Widget _buildSnapshotTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.18)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayMealsCard(BuildContext context) {
    final day = _todayKey();
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('mealPlans')
          .doc(day)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Failed to load today meals: ${snapshot.error}');
        }
        final data = snapshot.data?.data() ?? {};
        final Map<String, dynamic> meals =
            (data['meals'] as Map<String, dynamic>?) ?? {};
        final entries = meals.entries
            .where((entry) => entry.value.toString().trim().isNotEmpty)
            .toList();
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.today, size: 18, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    'Today\'s meals',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (entries.isEmpty)
                Text(
                  'No meals planned yet',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                )
              else
                ...entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${entry.key}: ${entry.value}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroBadgeStream({
    required IconData icon,
    required String label,
    required String collection,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Failed to load $collection: ${snapshot.error}');
        }
        final value = snapshot.hasData ? snapshot.data!.size.toString() : '--';
        return _HeroBadge(icon: icon, label: label, value: value);
      },
    );
  }

  String _todayKey() {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final index = DateTime.now().weekday - 1;
    return days[index.clamp(0, days.length - 1)];
  }

  Widget _buildAlertCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String chipLabel,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceTint,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  chipLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionPill(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.16),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (action != null) action!,
      ],
    );
  }
}
