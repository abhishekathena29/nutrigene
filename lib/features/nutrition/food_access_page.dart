import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class FoodAccessPage extends StatelessWidget {
  const FoodAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Food Access'),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primarySurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline_rounded, color: AppTheme.primaryColor, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Find affordable and nutritious food options for growing children.',
                    style: TextStyle(fontSize: 13, color: AppTheme.primaryColor, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Food Categories'),
          const SizedBox(height: 14),

          _FoodCategoryCard(
            icon: Icons.grass_rounded,
            title: 'Vegetables',
            items: 'Spinach, Carrots, Tomatoes',
            priceRange: '₹20–60/kg',
            color: AppTheme.primaryColor,
            bgColor: AppTheme.primarySurface,
            details: [
              'Spinach (₹30/kg): High in iron, calcium, and vitamins.',
              'Amaranth Leaves (₹20/kg): Packed with protein and vitamins.',
              'Carrots (₹40/kg): Excellent for Vitamin A and eye health.',
            ],
          ),
          const SizedBox(height: 10),
          _FoodCategoryCard(
            icon: Icons.apple_rounded,
            title: 'Fruits',
            items: 'Bananas, Guava, Papaya',
            priceRange: '₹40–120/kg',
            color: const Color(0xFFF97316),
            bgColor: const Color(0xFFFFF7ED),
            details: [
              'Bananas (₹40/doz): Excellent source of potassium and instant energy.',
              'Guava (₹50/kg): More Vitamin C than oranges.',
              'Papaya (₹40/kg): Great for digestion and affordable per serving.',
            ],
          ),
          const SizedBox(height: 10),
          _FoodCategoryCard(
            icon: Icons.set_meal_rounded,
            title: 'Proteins',
            items: 'Eggs, Lentils, Soy Chunks',
            priceRange: '₹80–250/kg',
            color: const Color(0xFFEF4444),
            bgColor: const Color(0xFFFEF2F2),
            details: [
              'Lentils/Dal (₹80–100/kg): Most cost-effective plant protein.',
              'Eggs (₹60/doz): High-quality complete protein.',
              'Soy Chunks (₹120/kg): Extremely high protein density per rupee.',
            ],
          ),
          const SizedBox(height: 10),
          _FoodCategoryCard(
            icon: Icons.rice_bowl_rounded,
            title: 'Grains',
            items: 'Rice, Millets, Oats',
            priceRange: '₹30–80/kg',
            color: const Color(0xFF92400E),
            bgColor: const Color(0xFFFEF3C7),
            details: [
              'Millets (₹40–60/kg): Ragi and Bajra are rich in calcium and iron.',
              'Brown Rice (₹60/kg): Better fiber content than white rice.',
              'Oats (₹150/kg): Great for heart health and satiety.',
            ],
          ),
          const SizedBox(height: 10),
          _FoodCategoryCard(
            icon: Icons.water_drop_rounded,
            title: 'Dairy',
            items: 'Milk, Curd, Paneer',
            priceRange: '₹50–200/L',
            color: AppTheme.secondaryColor,
            bgColor: const Color(0xFFEFF6FF),
            details: [
              'Toned Milk (₹50/L): Same protein and calcium as full cream but cheaper.',
              'Homemade Curd: Much cheaper than store-bought, great for gut health.',
              'Paneer (₹300/kg): Good vegetarian complete protein.',
            ],
          ),
          const SizedBox(height: 24),

          const _SectionTitle(title: 'Affordable Meal Bundles'),
          const SizedBox(height: 14),
          _BundleCard(
            title: 'Daily Essentials Bundle',
            description: 'Rice, Lentils, Vegetables, Cooking Oil',
            price: '₹350',
            servings: '4–5 meals',
          ),
          const SizedBox(height: 10),
          _BundleCard(
            title: 'Protein Pack',
            description: 'Eggs, Chicken, Beans, Milk',
            price: '₹500',
            servings: '6–7 meals',
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

class _FoodCategoryCard extends StatelessWidget {
  const _FoodCategoryCard({
    required this.icon,
    required this.title,
    required this.items,
    required this.priceRange,
    required this.color,
    required this.bgColor,
    required this.details,
  });

  final IconData icon;
  final String title;
  final String items;
  final String priceRange;
  final Color color;
  final Color bgColor;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        subtitle: Text(
          items,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        trailing: Text(
          priceRange,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        children: [
          Container(
            color: bgColor,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget-friendly, High-Nutrition Options:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 10),
                ...details.map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_rounded, size: 15, color: color),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            d,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textPrimary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _BundleCard extends StatelessWidget {
  const _BundleCard({
    required this.title,
    required this.description,
    required this.price,
    required this.servings,
  });

  final String title;
  final String description;
  final String price;
  final String servings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.restaurant_rounded, size: 14, color: AppTheme.textTertiary),
                    const SizedBox(width: 4),
                    Text(
                      servings,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textTertiary),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            price,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
