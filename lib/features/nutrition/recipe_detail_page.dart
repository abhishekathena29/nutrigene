import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
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
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: const Icon(Icons.favorite_border_rounded, size: 18, color: AppTheme.textPrimary),
                ),
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Added to favourites!'))),
              ),
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: const Icon(Icons.share_outlined, size: 18, color: AppTheme.textPrimary),
                ),
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Sharing recipe...'))),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFECFDF5), Color(0xFFF0FDF4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.rice_bowl_rounded, size: 100, color: Color(0xFF059669)),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Title & description
                const Text(
                  'Vegetable Rice Bowl',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'A colorful, nutritious rice bowl packed with vegetables — perfect for growing children.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Stats row
                Row(
                  children: [
                    _StatPill(icon: Icons.schedule_rounded, label: '25 min', color: AppTheme.secondaryColor),
                    const SizedBox(width: 10),
                    _StatPill(icon: Icons.local_fire_department_rounded, label: '320 kcal', color: const Color(0xFFF97316)),
                    const SizedBox(width: 10),
                    _StatPill(icon: Icons.people_outline_rounded, label: '2 servings', color: AppTheme.primaryColor),
                  ],
                ),
                const SizedBox(height: 28),

                // Nutrition
                const _SectionTitle(title: 'Nutritional Info'),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Column(
                    children: [
                      _NutrientRow(label: 'Protein', value: '12g', color: const Color(0xFFEF4444)),
                      const Divider(height: 20),
                      _NutrientRow(label: 'Carbohydrates', value: '45g', color: const Color(0xFFF97316)),
                      const Divider(height: 20),
                      _NutrientRow(label: 'Fat', value: '8g', color: const Color(0xFFF59E0B)),
                      const Divider(height: 20),
                      _NutrientRow(label: 'Fiber', value: '6g', color: AppTheme.primaryColor),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Ingredients
                const _SectionTitle(title: 'Ingredients'),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Column(
                    children: [
                      '1 cup white or brown rice',
                      '1 cup mixed vegetables (carrots, peas, corn)',
                      '1 small onion, chopped',
                      '2 cloves garlic, minced',
                      '2 tablespoons olive oil',
                      'Salt and pepper to taste',
                      'Fresh herbs (optional)',
                    ].map((ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: const BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 28),

                // Instructions
                const _SectionTitle(title: 'Instructions'),
                const SizedBox(height: 14),
                ...[
                  'Cook rice according to package instructions. Set aside.',
                  'Heat olive oil in a large pan over medium heat.',
                  'Sauté onion and garlic until fragrant, about 2–3 minutes.',
                  'Add mixed vegetables and cook until tender, about 5–7 minutes.',
                  'Add cooked rice to the pan and mix well with vegetables.',
                  'Season with salt and pepper. Cook for another 2–3 minutes.',
                  'Garnish with fresh herbs if desired and serve warm.',
                ].asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _StepCard(step: entry.key + 1, instruction: entry.value),
                  ),
                ),
                const SizedBox(height: 20),

                // Tips
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline_rounded, color: AppTheme.secondaryColor, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Chef\'s Tips',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        '• Use brown rice for extra fiber\n'
                        '• Add tofu or chicken for a complete meal\n'
                        '• Freeze individual portions for quick meals',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.secondaryColor,
                          height: 1.6,
                        ),
                      ),
                    ],
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

class _StatPill extends StatelessWidget {
  const _StatPill({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

class _NutrientRow extends StatelessWidget {
  const _NutrientRow({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step, required this.instruction});
  final int step;
  final String instruction;

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
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppTheme.primarySurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                instruction,
                style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
