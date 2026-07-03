import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class BrainNutritionTipsPage extends StatelessWidget {
  const BrainNutritionTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Brain Nutrition'),
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
          // Hero banner
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
                  child: const Icon(Icons.local_dining_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feed the Brain',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Nutrition for optimal cognitive development.',
                        style: TextStyle(fontSize: 12, color: Colors.white, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Essential Nutrients'),
          const SizedBox(height: 14),

          _NutrientCard(
            nutrient: 'Omega-3 Fatty Acids',
            benefit: 'Critical for brain structure and cognitive function',
            sources: ['Fatty fish (salmon, mackerel)', 'Walnuts', 'Chia seeds', 'Flaxseeds'],
            icon: Icons.water_drop_rounded,
            color: AppTheme.secondaryColor,
            bgColor: const Color(0xFFEFF6FF),
          ),
          const SizedBox(height: 10),
          _NutrientCard(
            nutrient: 'Iron',
            benefit: 'Essential for oxygen transport and neurotransmitter production',
            sources: ['Red meat', 'Spinach', 'Lentils', 'Fortified cereals'],
            icon: Icons.bloodtype_rounded,
            color: const Color(0xFFEF4444),
            bgColor: const Color(0xFFFEF2F2),
          ),
          const SizedBox(height: 10),
          _NutrientCard(
            nutrient: 'Protein',
            benefit: 'Building blocks for neurotransmitters and brain cells',
            sources: ['Eggs', 'Chicken', 'Beans', 'Greek yogurt', 'Nuts'],
            icon: Icons.egg_rounded,
            color: const Color(0xFF92400E),
            bgColor: const Color(0xFFFEF3C7),
          ),
          const SizedBox(height: 10),
          _NutrientCard(
            nutrient: 'Vitamin B Complex',
            benefit: 'Supports energy production and neurotransmitter synthesis',
            sources: ['Whole grains', 'Eggs', 'Dark leafy greens', 'Legumes'],
            icon: Icons.energy_savings_leaf_rounded,
            color: AppTheme.primaryColor,
            bgColor: AppTheme.primarySurface,
          ),
          const SizedBox(height: 10),
          _NutrientCard(
            nutrient: 'Choline',
            benefit: 'Important for memory and brain development',
            sources: ['Eggs', 'Beef liver', 'Soybeans', 'Chicken'],
            icon: Icons.psychology_rounded,
            color: const Color(0xFF7C3AED),
            bgColor: const Color(0xFFF5F3FF),
          ),
          const SizedBox(height: 10),
          _NutrientCard(
            nutrient: 'Zinc',
            benefit: 'Regulates neurotransmitter function and memory',
            sources: ['Pumpkin seeds', 'Beef', 'Chickpeas', 'Oysters'],
            icon: Icons.grain_rounded,
            color: const Color(0xFFF97316),
            bgColor: const Color(0xFFFFF7ED),
          ),
          const SizedBox(height: 10),
          _NutrientCard(
            nutrient: 'Antioxidants',
            benefit: 'Protect brain cells from oxidative stress',
            sources: ['Berries', 'Dark chocolate', 'Green tea', 'Colorful vegetables'],
            icon: Icons.shield_rounded,
            color: const Color(0xFF6366F1),
            bgColor: const Color(0xFFEEF2FF),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Brain-Boosting Meal Ideas'),
          const SizedBox(height: 14),

          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _MealRow(
                  type: 'Breakfast',
                  description: 'Oatmeal with berries, walnuts, and a drizzle of honey',
                  icon: Icons.wb_sunny_rounded,
                  color: const Color(0xFFF97316),
                  isLast: false,
                ),
                _MealRow(
                  type: 'Lunch',
                  description: 'Salmon with quinoa and steamed broccoli',
                  icon: Icons.lunch_dining_rounded,
                  color: AppTheme.secondaryColor,
                  isLast: false,
                ),
                _MealRow(
                  type: 'Snack',
                  description: 'Apple slices with almond butter',
                  icon: Icons.apple_rounded,
                  color: const Color(0xFF92400E),
                  isLast: false,
                ),
                _MealRow(
                  type: 'Dinner',
                  description: 'Whole grain pasta with spinach and chickpeas',
                  icon: Icons.dinner_dining_rounded,
                  color: AppTheme.primaryColor,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Important Tips'),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: const [
                _TipRow(tip: 'Stay hydrated — water is essential for brain function'),
                Divider(height: 20),
                _TipRow(tip: 'Eat regular meals to maintain stable blood sugar'),
                Divider(height: 20),
                _TipRow(tip: 'Limit processed foods and added sugars'),
                Divider(height: 20),
                _TipRow(tip: 'Include a variety of colorful fruits and vegetables'),
                Divider(height: 20),
                _TipRow(tip: 'Encourage family meals to support healthy eating habits'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Reminder
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded, color: AppTheme.warningColor, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Remember',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'A balanced diet with variety is key to providing all the nutrients needed for optimal brain development. The earlier healthy eating habits are established, the better!',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.warningColor,
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

class _NutrientCard extends StatelessWidget {
  const _NutrientCard({
    required this.nutrient,
    required this.benefit,
    required this.sources,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final String nutrient;
  final String benefit;
  final List<String> sources;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nutrient,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      benefit,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Sources',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: sources.map(
                    (source) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        source,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MealRow extends StatelessWidget {
  const _MealRow({
    required this.type,
    required this.description,
    required this.icon,
    required this.color,
    required this.isLast,
  });

  final String type;
  final String description;
  final IconData icon;
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
                      type,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary, height: 1.4),
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

class _TipRow extends StatelessWidget {
  const _TipRow({required this.tip});
  final String tip;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_rounded, color: AppTheme.primaryColor, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            tip,
            style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary, height: 1.5),
          ),
        ),
      ],
    );
  }
}
