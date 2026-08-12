import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/core/widgets/app_logo.dart';
import 'package:nutritrack/core/widgets/sources_link.dart';
import 'package:nutritrack/l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(l10n.moreAboutNutriGene),
        leading: IconButton(
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 18,
              color: AppTheme.textPrimary,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          // Logo + name
          Center(
            child: Column(
              children: [
                const AppLogo(
                  size: 96,
                  padding: 14,
                  backgroundColor: Colors.white,
                  borderRadius: 28,
                  showBorder: true,
                ),
                const SizedBox(height: 16),
                const Text(
                  'NutriGene',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.aboutVersion,
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Mission
          _SectionTitle(title: l10n.aboutOurMission),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Text(
              l10n.aboutMissionBody,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Features
          _SectionTitle(title: l10n.aboutKeyFeatures),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _FeatureRow(
                  icon: Icons.trending_up_rounded,
                  color: AppTheme.primaryColor,
                  bgColor: AppTheme.primarySurface,
                  title: l10n.aboutFeatureGrowthTitle,
                  description: l10n.aboutFeatureGrowthDesc,
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.auto_awesome_rounded,
                  color: AppTheme.secondaryColor,
                  bgColor: const Color(0xFFEFF6FF),
                  title: l10n.aboutFeatureAiTitle,
                  description: l10n.aboutFeatureAiDesc,
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.science_rounded,
                  color: const Color(0xFF7C3AED),
                  bgColor: const Color(0xFFF5F3FF),
                  title: l10n.aboutFeatureEpigeneticTitle,
                  description: l10n.aboutFeatureEpigeneticDesc,
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.psychology_rounded,
                  color: const Color(0xFFF97316),
                  bgColor: const Color(0xFFFFF7ED),
                  title: l10n.aboutFeatureBrainTitle,
                  description: l10n.aboutFeatureBrainDesc,
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.business_rounded,
                  color: const Color(0xFF6366F1),
                  bgColor: const Color(0xFFEEF2FF),
                  title: l10n.aboutFeatureNgoTitle,
                  description: l10n.aboutFeatureNgoDesc,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Impact
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.heroGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  l10n.aboutImpactTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.aboutImpactBody,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Contact
          _SectionTitle(title: l10n.aboutGetInTouch),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _ContactRow(
                  icon: Icons.email_outlined,
                  iconColor: AppTheme.primaryColor,
                  iconBg: AppTheme.primarySurface,
                  label: l10n.moreEmailLabel,
                  value: 'support@nutrigene.org',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56),
                _ContactRow(
                  icon: Icons.language_rounded,
                  iconColor: AppTheme.secondaryColor,
                  iconBg: const Color(0xFFEFF6FF),
                  label: l10n.aboutWebsiteLabel,
                  value: 'www.nutrigene.org',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56),
                _ContactRow(
                  icon: Icons.share_outlined,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFF5F3FF),
                  label: l10n.aboutSocialMediaLabel,
                  value: l10n.aboutSocialMediaValue,
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Sources & medical disclaimer
          _SectionTitle(title: l10n.aboutMedicalInfo),
          const SizedBox(height: 12),
          const SourcesLink(),
          const SizedBox(height: 28),

          Center(
            child: Text(
              l10n.aboutCopyright,
              style: const TextStyle(fontSize: 12, color: AppTheme.textTertiary),
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

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  final IconData icon;
  final Color color;
  final Color bgColor;
  final String title;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppTheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
