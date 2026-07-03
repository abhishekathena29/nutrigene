import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class EpigeneticRiskPage extends StatefulWidget {
  const EpigeneticRiskPage({super.key});

  @override
  State<EpigeneticRiskPage> createState() => _EpigeneticRiskPageState();
}

class _EpigeneticRiskPageState extends State<EpigeneticRiskPage> {
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

  // Compute risk score (0–10) based on latest MUAC and growth trend
  _RiskResult _computeRisk(List<GrowthRecord> records) {
    if (records.isEmpty) {
      return _RiskResult(score: 0, label: 'No Data', color: AppTheme.textTertiary);
    }
    final latest = records.first;
    final muac = latest.muac;

    if (muac < 11.5) {
      return _RiskResult(score: 9.5, label: 'Severe Acute Malnutrition', color: AppTheme.errorColor);
    } else if (muac < 12.5) {
      return _RiskResult(score: 7.5, label: 'Moderate Acute Malnutrition', color: const Color(0xFFF97316));
    } else if (muac < 13.5) {
      return _RiskResult(score: 5.5, label: 'At Risk', color: AppTheme.warningColor);
    } else {
      return _RiskResult(score: 2.0, label: 'Normal', color: AppTheme.primaryColor);
    }
  }

  List<_FactorData> _computeFactors(List<GrowthRecord> records) {
    if (records.isEmpty) return [];
    final latest = records.first;
    return [
      _FactorData(
        title: 'MUAC Status',
        description: 'Mid-upper arm circumference: ${latest.muac.toStringAsFixed(1)} cm',
        risk: latest.muac < 11.5
            ? 'Severe'
            : latest.muac < 12.5
                ? 'Moderate'
                : latest.muac < 13.5
                    ? 'At Risk'
                    : 'Normal',
        color: latest.muac < 11.5
            ? AppTheme.errorColor
            : latest.muac < 12.5
                ? const Color(0xFFF97316)
                : latest.muac < 13.5
                    ? AppTheme.warningColor
                    : AppTheme.primaryColor,
        icon: Icons.straighten_rounded,
      ),
      _FactorData(
        title: 'Weight Status',
        description: 'Latest recorded weight: ${latest.weight.toStringAsFixed(1)} kg',
        risk: latest.weight < 5
            ? 'High'
            : latest.weight < 10
                ? 'Moderate'
                : 'Normal',
        color: latest.weight < 5
            ? AppTheme.errorColor
            : latest.weight < 10
                ? AppTheme.warningColor
                : AppTheme.primaryColor,
        icon: Icons.monitor_weight_outlined,
      ),
      if (records.length >= 2)
        _FactorData(
          title: 'Growth Trend',
          description: 'Weight change: ${(latest.weight - records.last.weight).toStringAsFixed(1)} kg over ${records.length} records',
          risk: (latest.weight - records.last.weight) < 0 ? 'Declining' : 'Improving',
          color: (latest.weight - records.last.weight) < 0 ? AppTheme.warningColor : AppTheme.primaryColor,
          icon: Icons.trending_up_rounded,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChildrenProvider>();
    final child = provider.getChildById(_childId);
    final records = _childId == null ? <GrowthRecord>[] : provider.getGrowthForChild(_childId!);
    final risk = _computeRisk(records);
    final factors = _computeFactors(records);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(child != null ? '${child.name} — Epigenetic Risk' : 'Epigenetic Risk'),
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
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // About card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.science_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Epigenetic Risk',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Epigenetics studies how environmental factors like nutrition affect gene expression and long-term health outcomes in children.',
                        style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (records.isEmpty) ...[
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  const Icon(Icons.bar_chart_rounded, size: 48, color: AppTheme.textTertiary),
                  const SizedBox(height: 16),
                  const Text(
                    'No growth data available',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add growth measurements to compute the epigenetic risk score.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 20),
                  if (_childId != null)
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/child/growth-input', arguments: _childId),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Add measurement'),
                    ),
                ],
              ),
            ),
          ] else ...[
            // Risk score
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  const Text(
                    'Current Risk Score',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 130,
                        child: CircularProgressIndicator(
                          value: risk.score / 10,
                          strokeWidth: 10,
                          backgroundColor: AppTheme.borderColor,
                          valueColor: AlwaysStoppedAnimation<Color>(risk.color),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            risk.score.toStringAsFixed(1),
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: risk.color),
                          ),
                          Text(
                            'out of 10',
                            style: TextStyle(fontSize: 12, color: AppTheme.textTertiary, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: risk.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      risk.label,
                      style: TextStyle(color: risk.color, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const _SectionTitle(title: 'Risk Factors'),
            const SizedBox(height: 14),
            ...factors.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _RiskFactorCard(
                title: f.title,
                description: f.description,
                risk: f.risk,
                color: f.color,
                icon: f.icon,
              ),
            )),
            const SizedBox(height: 24),

            const _SectionTitle(title: 'Recommendations'),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  _RecommendationRow(text: 'Increase intake of iron-rich foods'),
                  const Divider(height: 20),
                  _RecommendationRow(text: 'Regular vitamin D supplementation'),
                  const Divider(height: 20),
                  _RecommendationRow(text: 'Enhance protein sources in diet'),
                  const Divider(height: 20),
                  _RecommendationRow(text: 'Follow-up assessment in 3 months'),
                ],
              ),
            ),
          ],
          const SizedBox(height: 28),

          ElevatedButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Generating detailed report...')),
            ),
            icon: const Icon(Icons.description_outlined, size: 18),
            label: const Text('Generate Detailed Report'),
          ),
        ],
      ),
    );
  }
}

class _RiskResult {
  const _RiskResult({required this.score, required this.label, required this.color});
  final double score;
  final String label;
  final Color color;
}

class _FactorData {
  const _FactorData({
    required this.title,
    required this.description,
    required this.risk,
    required this.color,
    required this.icon,
  });
  final String title;
  final String description;
  final String risk;
  final Color color;
  final IconData icon;
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

class _RiskFactorCard extends StatelessWidget {
  const _RiskFactorCard({
    required this.title,
    required this.description,
    required this.risk,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final String risk;
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
            child: Text(risk, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
          ),
        ],
      ),
    );
  }
}

class _RecommendationRow extends StatelessWidget {
  const _RecommendationRow({required this.text});
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
