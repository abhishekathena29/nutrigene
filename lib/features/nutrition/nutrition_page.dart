import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text('Nutrition'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Hero banner
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF0EA5E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.restaurant_menu_rounded, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nutrition Hub',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Meal plans, recipes, and nutritional insights.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const _SectionLabel(label: 'EXPLORE'),
          const SizedBox(height: 12),

          _MenuCard(
            icon: Icons.shopping_basket_outlined,
            title: 'Food Access & Affordability',
            description: 'Nutritious options at affordable prices',
            color: AppTheme.primaryColor,
            bgColor: AppTheme.primarySurface,
            route: '/nutrition/access',
          ),
          const SizedBox(height: 12),
          _MenuCard(
            icon: Icons.calendar_month_outlined,
            title: 'Meal Plans',
            description: 'AI-powered weekly meal suggestions',
            color: const Color(0xFFF97316),
            bgColor: const Color(0xFFFFF7ED),
            route: '/nutrition/meal-plan',
          ),
          const SizedBox(height: 12),
          _MenuCard(
            icon: Icons.menu_book_outlined,
            title: 'Recipes',
            description: 'Nutritious recipes designed for children',
            color: AppTheme.secondaryColor,
            bgColor: const Color(0xFFEFF6FF),
            route: '/nutrition/recipes',
          ),
          const SizedBox(height: 12),
          _MenuCard(
            icon: Icons.health_and_safety_outlined,
            title: 'Symptoms Checker',
            description: 'Check for nutritional deficiencies',
            color: const Color(0xFFEF4444),
            bgColor: const Color(0xFFFEF2F2),
            route: '/nutrition/symptoms',
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppTheme.textTertiary,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.bgColor,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final Color bgColor;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textTertiary),
          ],
        ),
      ),
    );
  }
}
