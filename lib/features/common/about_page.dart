import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/core/widgets/app_logo.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('About NutriGene'),
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
                const Text(
                  'Version 1.0.0',
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Mission
          const _SectionTitle(title: 'Our Mission'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Text(
              'NutriGene is an AI-powered nutrition tracker and assistant designed to combat child malnutrition through personalized nutrition recommendations, growth monitoring, and early intervention.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Features
          const _SectionTitle(title: 'Key Features'),
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
                  title: 'Growth Tracking',
                  description: 'Monitor children\'s growth using WHO standards',
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.auto_awesome_rounded,
                  color: AppTheme.secondaryColor,
                  bgColor: const Color(0xFFEFF6FF),
                  title: 'AI Recommendations',
                  description: 'Personalized nutrition advice powered by AI',
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.science_rounded,
                  color: const Color(0xFF7C3AED),
                  bgColor: const Color(0xFFF5F3FF),
                  title: 'Epigenetic Risk Assessment',
                  description: 'Early detection of nutritional deficiencies',
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.psychology_rounded,
                  color: const Color(0xFFF97316),
                  bgColor: const Color(0xFFFFF7ED),
                  title: 'Brain Development',
                  description:
                      'Activities and nutrition tips for cognitive growth',
                ),
                const Divider(height: 1, indent: 70),
                _FeatureRow(
                  icon: Icons.business_rounded,
                  color: const Color(0xFF6366F1),
                  bgColor: const Color(0xFFEEF2FF),
                  title: 'NGO Support',
                  description:
                      'Tools for organizations managing multiple children',
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
            child: const Column(
              children: [
                Text(
                  'Together, we can end child malnutrition',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  'NutriGene is expanding its reach to help NGOs, caregivers, and health workers monitor child growth, combat malnutrition, and provide actionable AI insights worldwide.',
                  style: TextStyle(
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
          const _SectionTitle(title: 'Get in Touch'),
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
                  label: 'Email',
                  value: 'support@nutrigene.org',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56),
                _ContactRow(
                  icon: Icons.language_rounded,
                  iconColor: AppTheme.secondaryColor,
                  iconBg: const Color(0xFFEFF6FF),
                  label: 'Website',
                  value: 'www.nutrigene.org',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56),
                _ContactRow(
                  icon: Icons.share_outlined,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFF5F3FF),
                  label: 'Social Media',
                  value: 'Follow us on social platforms',
                  onTap: () {},
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          const Center(
            child: Text(
              '© 2025 NutriGene. All rights reserved.',
              style: TextStyle(fontSize: 12, color: AppTheme.textTertiary),
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
