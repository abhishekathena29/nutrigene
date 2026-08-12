import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

/// A single referenced source used to inform the health / nutrition
/// information shown throughout the app.
class SourceCitation {
  const SourceCitation({
    required this.title,
    required this.publisher,
    required this.usedFor,
    required this.url,
  });

  final String title;
  final String publisher;
  final String usedFor;
  final String url;
}

/// Sources and references that inform the growth, MUAC, symptom and
/// nutrition information presented in NutriGene. Shown to users so the
/// medical/health information in the app is properly cited.
const List<SourceCitation> kNutriGeneSources = [
  SourceCitation(
    title: 'WHO Child Growth Standards',
    publisher: 'World Health Organization',
    usedFor:
        'Weight-for-age, height-for-age, weight-for-height, BMI-for-age, percentiles, and Z-scores.',
    url: 'https://www.who.int/tools/child-growth-standards',
  ),
  SourceCitation(
    title:
        'Identification of Severe Acute Malnutrition in Infants and Children',
    publisher: 'World Health Organization and UNICEF',
    usedFor:
        'General MUAC screening and acute-malnutrition classification information.',
    url: 'https://www.who.int/publications/i/item/9789241598163',
  ),
  SourceCitation(
    title:
        'Guideline for Complementary Feeding of Infants and Young Children 6–23 Months of Age',
    publisher: 'World Health Organization',
    usedFor:
        'Age-appropriate feeding, food diversity, and meal guidance.',
    url: 'https://www.who.int/publications/i/item/9789240081864',
  ),
  SourceCitation(
    title: 'Dietary Guidelines for Indians 2024',
    publisher: 'ICMR – National Institute of Nutrition',
    usedFor:
        'Indian food groups, balanced diets, meal planning, and nutrition education.',
    url: 'https://www.nin.res.in/dietaryguidelines.html',
  ),
  SourceCitation(
    title: 'Nutritional Goals by Age and Sex Group',
    publisher: 'U.S. Department of Health and Human Services',
    usedFor:
        'General age- and sex-specific nutrient reference information.',
    url:
        'https://odphp.health.gov/sites/default/files/2019-09/Appendix-E3-1-Table-A4.pdf',
  ),
  SourceCitation(
    title: 'Nutrition Reference Compendium',
    publisher:
        'Central Council for Research in Homoeopathy, Government of India',
    usedFor:
        'Reference for nutrition information and commonly consumed foods.',
    url:
        'https://www.ccrhindia.nic.in/WriteReadData/LINKS/Compendium0c3fc504-fd77-45ab-9148-2407a787276c.pdf',
  ),
];

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open link: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Sources & References'),
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
          // Intro
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.primarySurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.menu_book_rounded,
                    color: AppTheme.primaryColor, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'The growth-monitoring, MUAC, symptom and nutrition information in NutriGene is based on the public health guidelines listed below. Tap any source to open the original publication.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textPrimary,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Information Sources'),
          const SizedBox(height: 12),
          ...kNutriGeneSources.map(
            (source) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SourceCard(
                source: source,
                onTap: () => _openUrl(context, source.url),
              ),
            ),
          ),

          const SizedBox(height: 12),
          const _SectionTitle(title: 'Medical Disclaimer'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: AppTheme.warningColor, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Important',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'NutriGene is intended for general informational, educational, growth-monitoring, and wellness purposes only.\n\n'
                  'The app does not provide medical advice, diagnosis, treatment, prescriptions, therapeutic diets, or emergency medical services. It should not replace consultation with a qualified healthcare professional.\n\n'
                  'Growth measurements, MUAC classifications, symptom information, meal suggestions, and nutrition recommendations are general screening or educational information only and do not confirm malnutrition, nutrient deficiency, illness, or any medical condition.\n\n'
                  'Always seek advice from a doctor, paediatrician, registered dietitian, or other qualified healthcare professional before making decisions about a child’s health, diet, supplements, medication, or treatment.\n\n'
                  'Do not disregard professional medical advice or delay seeking care because of information provided by NutriGene.\n\n'
                  'In a medical emergency, contact local emergency services immediately.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                    height: 1.6,
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

class _SourceCard extends StatelessWidget {
  const _SourceCard({required this.source, required this.onTap});

  final SourceCitation source;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primarySurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.link_rounded,
                  size: 20, color: AppTheme.primaryColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    source.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    source.publisher,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Used for: ${source.usedFor}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.open_in_new_rounded,
                          size: 13, color: AppTheme.textTertiary),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          source.url,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
