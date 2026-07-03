import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class CaregiverReportPage extends StatefulWidget {
  const CaregiverReportPage({super.key});

  @override
  State<CaregiverReportPage> createState() => _CaregiverReportPageState();
}

class _CaregiverReportPageState extends State<CaregiverReportPage> {
  String? _childId;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _childId ??= ModalRoute.of(context)?.settings.arguments as String?;
    final provider = context.read<ChildrenProvider>();
    if (_childId != null && !_loaded) {
      if (provider.children.isEmpty) provider.loadChildren();
      provider.loadGrowthRecords(_childId!);
      _loaded = true;
    }
  }

  String _ageString(DateTime dob) {
    final now = DateTime.now();
    int years = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) years--;
    if (years == 0) {
      final months = now.month - dob.month + (now.year - dob.year) * 12;
      return '$months months old';
    }
    return '$years years old';
  }

  double? _bmi(double weight, double height) {
    if (height <= 0) return null;
    return weight / ((height / 100) * (height / 100));
  }

  String _nutritionStatus(List<GrowthRecord> records) {
    if (records.isEmpty) return 'No data';
    final muac = records.first.muac;
    if (muac < 11.5) return 'Severe Malnutrition';
    if (muac < 12.5) return 'Moderate Malnutrition';
    if (muac < 13.5) return 'At Risk';
    return 'Good';
  }

  Color _nutritionColor(List<GrowthRecord> records) {
    if (records.isEmpty) return AppTheme.textTertiary;
    final muac = records.first.muac;
    if (muac < 11.5) return AppTheme.errorColor;
    if (muac < 12.5) return const Color(0xFFF97316);
    if (muac < 13.5) return AppTheme.warningColor;
    return AppTheme.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChildrenProvider>();
    final child = provider.getChildById(_childId);
    final records = _childId == null ? <GrowthRecord>[] : provider.getGrowthForChild(_childId!);
    final today = DateTime.now();
    final dateStr = '${_monthName(today.month)} ${today.day}, ${today.year}';

    if (child == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final latest = records.isNotEmpty ? records.first : null;
    final bmi = latest != null ? _bmi(latest.weight, latest.height) : null;
    final isFemale = child.gender.toLowerCase().startsWith('f');

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Caregiver Report'),
        leading: IconButton(
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppTheme.textPrimary),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Sharing report...'))),
          ),
          IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Downloading report...'))),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Child header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.heroGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFemale ? Icons.girl_rounded : Icons.boy_rounded,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.name,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_ageString(child.dob)} · ${child.gender}',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    dateStr,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Summary
          const _SectionTitle(title: 'Summary'),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Text(
              records.isEmpty
                  ? '${child.name} has no recorded growth data yet. Add measurements to generate a full nutritional summary.'
                  : '${child.name} has ${records.length} growth record${records.length == 1 ? '' : 's'}. '
                      'Latest measurement recorded on ${records.first.date.toLocal().toString().split(' ').first}. '
                      'Nutritional status: ${_nutritionStatus(records)}.',
              style: const TextStyle(fontSize: 14, height: 1.6, color: AppTheme.textPrimary),
            ),
          ),
          const SizedBox(height: 24),

          if (latest != null) ...[
            const _SectionTitle(title: 'Growth Metrics'),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    label: 'Weight',
                    value: '${latest.weight.toStringAsFixed(1)} kg',
                    icon: Icons.monitor_weight_outlined,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    label: 'Height',
                    value: '${latest.height.toStringAsFixed(1)} cm',
                    icon: Icons.height_rounded,
                    color: AppTheme.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    label: 'MUAC',
                    value: '${latest.muac.toStringAsFixed(1)} cm',
                    icon: Icons.straighten_rounded,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricCard(
                    label: 'BMI',
                    value: bmi != null ? bmi.toStringAsFixed(1) : '—',
                    icon: Icons.calculate_outlined,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Nutrition status
            const _SectionTitle(title: 'Nutrition Status'),
            const SizedBox(height: 14),
            _StatusCard(
              title: 'Overall Nutrition',
              status: _nutritionStatus(records),
              description: 'Based on latest MUAC measurement',
              color: _nutritionColor(records),
              icon: Icons.monitor_heart_outlined,
            ),
            const SizedBox(height: 10),
            _StatusCard(
              title: 'Micronutrients',
              status: 'Needs Attention',
              description: 'Consider increasing iron and vitamin D',
              color: AppTheme.warningColor,
              icon: Icons.warning_amber_rounded,
            ),
            const SizedBox(height: 24),
          ],

          // Recommendations
          const _SectionTitle(title: 'Recommendations'),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _RecommendationItem(text: 'Continue current feeding schedule'),
                const Divider(height: 20),
                _RecommendationItem(text: 'Increase variety of green vegetables'),
                const Divider(height: 20),
                _RecommendationItem(text: 'Add iron-rich foods to diet'),
                const Divider(height: 20),
                _RecommendationItem(text: 'Ensure adequate vitamin D exposure'),
                const Divider(height: 20),
                _RecommendationItem(text: 'Schedule follow-up in 3 months'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          ElevatedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Downloading PDF report...'))),
            icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
            label: const Text('Download PDF Report'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Scheduling appointment...'))),
            icon: const Icon(Icons.calendar_today_outlined, size: 18),
            label: const Text('Schedule Follow-up'),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
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

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.label, required this.value, required this.icon, required this.color});
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: color)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.title,
    required this.status,
    required this.description,
    required this.color,
    required this.icon,
  });
  final String title;
  final String status;
  final String description;
  final Color color;
  final IconData icon;

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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                const SizedBox(height: 3),
                Text(description, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          ),
        ],
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  const _RecommendationItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(color: AppTheme.primarySurface, shape: BoxShape.circle),
          child: const Icon(Icons.check_rounded, size: 14, color: AppTheme.primaryColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary, height: 1.4)),
        ),
      ],
    );
  }
}
