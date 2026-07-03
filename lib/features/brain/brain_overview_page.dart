import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class BrainOverviewPage extends StatelessWidget {
  const BrainOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Brain Development'),
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
          // Hero card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.brainGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Early Brain Development',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'The foundation for lifelong learning and potential.',
                        style: TextStyle(fontSize: 12, color: Colors.white, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Intro
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Text(
              'Brain development in children is a complex process that begins before birth and continues into early adulthood. The first few years of life are particularly critical — the brain forms more than 1 million neural connections every second.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Key Development Stages'),
          const SizedBox(height: 14),

          _StageCard(
            age: '0–3 Years',
            title: 'Rapid Brain Growth',
            description: 'The brain reaches 80% of adult size. Critical period for language, sensory, and motor skill development.',
            icon: Icons.child_care_rounded,
            color: const Color(0xFFEC4899),
            bgColor: const Color(0xFFFDF2F8),
          ),
          const SizedBox(height: 10),
          _StageCard(
            age: '3–6 Years',
            title: 'Social & Emotional Development',
            description: 'Development of self-control, emotional regulation, and social skills. Language skills expand rapidly.',
            icon: Icons.people_rounded,
            color: AppTheme.secondaryColor,
            bgColor: const Color(0xFFEFF6FF),
          ),
          const SizedBox(height: 10),
          _StageCard(
            age: '6–12 Years',
            title: 'Cognitive Growth',
            description: 'Improved attention span, problem-solving abilities, and logical thinking. Academic skills develop.',
            icon: Icons.school_rounded,
            color: AppTheme.primaryColor,
            bgColor: AppTheme.primarySurface,
          ),
          const SizedBox(height: 10),
          _StageCard(
            age: '12+ Years',
            title: 'Executive Functions',
            description: 'Development of planning, decision-making, and impulse control. Brain continues maturing into mid-20s.',
            icon: Icons.psychology_rounded,
            color: const Color(0xFF7C3AED),
            bgColor: const Color(0xFFF5F3FF),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Factors Affecting Development'),
          const SizedBox(height: 14),

          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _FactorRow(
                  icon: Icons.restaurant_rounded,
                  title: 'Nutrition',
                  description: 'Proper nutrition provides essential building blocks for brain cells.',
                  color: const Color(0xFFF97316),
                  isLast: false,
                ),
                _FactorRow(
                  icon: Icons.toys_rounded,
                  title: 'Stimulation',
                  description: 'Interactive play, reading, and conversation promote neural pathways.',
                  color: AppTheme.secondaryColor,
                  isLast: false,
                ),
                _FactorRow(
                  icon: Icons.bedtime_rounded,
                  title: 'Sleep',
                  description: 'Adequate sleep is crucial for memory consolidation and development.',
                  color: const Color(0xFF7C3AED),
                  isLast: false,
                ),
                _FactorRow(
                  icon: Icons.directions_run_rounded,
                  title: 'Physical Activity',
                  description: 'Exercise improves blood flow to the brain and cognitive function.',
                  color: AppTheme.primaryColor,
                  isLast: false,
                ),
                _FactorRow(
                  icon: Icons.favorite_rounded,
                  title: 'Emotional Safety',
                  description: 'Secure attachment and stress-free environments promote healthy growth.',
                  color: const Color(0xFFEF4444),
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Takeaway
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.primarySurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded, color: AppTheme.primaryColor, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Key Takeaway',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Early experiences and nutrition have lasting impacts on brain architecture. Providing proper nutrition, stimulation, and care during childhood sets the foundation for lifelong cognitive abilities and well-being.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.primaryColor,
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

class _StageCard extends StatelessWidget {
  const _StageCard({
    required this.age,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final String age;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color bgColor;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
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
                  age,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.5,
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

class _FactorRow extends StatelessWidget {
  const _FactorRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.isLast,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
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
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, indent: 70),
      ],
    );
  }
}
