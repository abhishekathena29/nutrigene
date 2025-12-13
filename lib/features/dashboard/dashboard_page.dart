import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildStatCard(
                  context,
                  icon: Icons.child_care,
                  title: 'Children',
                  value: '3',
                  color: theme.colorScheme.primary,
                ),
                _buildStatCard(
                  context,
                  icon: Icons.restaurant_menu,
                  title: 'Meals',
                  value: '45',
                  color: theme.colorScheme.secondary,
                ),
                _buildStatCard(
                  context,
                  icon: Icons.warning_amber_rounded,
                  title: 'Alerts',
                  value: '2',
                  color: Colors.amber.shade700,
                ),
                _buildStatCard(
                  context,
                  icon: Icons.psychology,
                  title: 'Activities',
                  value: '12',
                  color: Colors.indigo.shade400,
                ),
              ],
            ),
            const SizedBox(height: 28),
            const _SectionTitle(title: 'Key Alerts'),
            const SizedBox(height: 12),
            _buildAlertCard(
              context,
              icon: Icons.schedule_send,
              title: 'Nutritional assessment due',
              subtitle: 'Schedule Emma’s check-in this week',
              chipLabel: 'Due soon',
              onTap: () => Navigator.pushNamed(context, '/child/growth-input'),
            ),
            const SizedBox(height: 12),
            _buildAlertCard(
              context,
              icon: Icons.auto_awesome,
              title: 'New brain activities available',
              subtitle: '3 fresh activities to boost cognition',
              chipLabel: 'Recommended',
              onTap: () => Navigator.pushNamed(context, '/brain/activities'),
            ),
            const SizedBox(height: 28),
            const _SectionTitle(title: 'Quick Actions'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildActionPill(
                  context,
                  icon: Icons.add_circle,
                  label: 'Add child',
                  onTap: () => Navigator.pushNamed(context, '/child/form'),
                ),
                _buildActionPill(
                  context,
                  icon: Icons.restaurant_menu,
                  label: 'Meal plans',
                  onTap: () =>
                      Navigator.pushNamed(context, '/nutrition/meal-plan'),
                ),
                _buildActionPill(
                  context,
                  icon: Icons.analytics_outlined,
                  label: 'Growth chart',
                  onTap: () =>
                      Navigator.pushNamed(context, '/child/growth-chart'),
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
              _HeroBadge(
                icon: Icons.star_rate_rounded,
                label: 'Wellness score',
                value: '86',
              ),
              const SizedBox(width: 10),
              _HeroBadge(
                icon: Icons.local_dining,
                label: 'Meals logged',
                value: '12',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: (MediaQuery.of(context).size.width),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
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
