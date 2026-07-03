import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class RecipesListPage extends StatefulWidget {
  const RecipesListPage({super.key});

  @override
  State<RecipesListPage> createState() => _RecipesListPageState();
}

class _RecipesListPageState extends State<RecipesListPage> {
  static const _recipes = [
    (
      title: 'Vegetable Rice Bowl',
      description: 'Colorful rice bowl with mixed vegetables',
      prepTime: '25 min',
      difficulty: 'Easy',
      calories: '320 kcal',
      icon: Icons.rice_bowl_rounded,
      color: Color(0xFF059669),
      bgColor: Color(0xFFECFDF5),
    ),
    (
      title: 'Banana Oat Pancakes',
      description: 'Healthy pancakes made with banana and oats',
      prepTime: '15 min',
      difficulty: 'Easy',
      calories: '250 kcal',
      icon: Icons.breakfast_dining_rounded,
      color: Color(0xFFF97316),
      bgColor: Color(0xFFFFF7ED),
    ),
    (
      title: 'Chicken Veggie Soup',
      description: 'Warm soup packed with protein and vegetables',
      prepTime: '40 min',
      difficulty: 'Medium',
      calories: '280 kcal',
      icon: Icons.soup_kitchen_rounded,
      color: Color(0xFFEF4444),
      bgColor: Color(0xFFFEF2F2),
    ),
    (
      title: 'Spinach & Cheese Quesadilla',
      description: 'Kid-friendly quesadilla with hidden spinach',
      prepTime: '20 min',
      difficulty: 'Easy',
      calories: '310 kcal',
      icon: Icons.lunch_dining_rounded,
      color: Color(0xFF059669),
      bgColor: Color(0xFFECFDF5),
    ),
    (
      title: 'Fruit Smoothie Bowl',
      description: 'Refreshing smoothie bowl topped with fruits',
      prepTime: '10 min',
      difficulty: 'Easy',
      calories: '220 kcal',
      icon: Icons.icecream_rounded,
      color: Color(0xFFEC4899),
      bgColor: Color(0xFFFDF2F8),
    ),
    (
      title: 'Lentil Dal with Rice',
      description: 'Traditional dal rich in protein and iron',
      prepTime: '35 min',
      difficulty: 'Medium',
      calories: '340 kcal',
      icon: Icons.set_meal_rounded,
      color: Color(0xFF92400E),
      bgColor: Color(0xFFFEF3C7),
    ),
    (
      title: 'Sweet Potato Fries',
      description: 'Baked sweet potato fries — healthy snack',
      prepTime: '30 min',
      difficulty: 'Easy',
      calories: '180 kcal',
      icon: Icons.fastfood_rounded,
      color: Color(0xFFF97316),
      bgColor: Color(0xFFFFF7ED),
    ),
  ];

  final _searchController = TextEditingController();
  String _query = '';
  bool _searching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<({String title, String description, String prepTime, String difficulty, String calories, IconData icon, Color color, Color bgColor})> get _filtered {
    if (_query.trim().isEmpty) return _recipes;
    final q = _query.toLowerCase();
    return _recipes.where((r) =>
      r.title.toLowerCase().contains(q) ||
      r.description.toLowerCase().contains(q) ||
      r.difficulty.toLowerCase().contains(q),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: _searching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search recipes...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppTheme.textTertiary),
                ),
                style: const TextStyle(fontSize: 16, color: AppTheme.textPrimary),
                onChanged: (v) => setState(() => _query = v),
              )
            : const Text('Recipes'),
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
          onPressed: () {
            if (_searching) {
              setState(() {
                _searching = false;
                _query = '';
                _searchController.clear();
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(_searching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () {
              setState(() {
                if (_searching) {
                  _searching = false;
                  _query = '';
                  _searchController.clear();
                } else {
                  _searching = true;
                }
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            filtered.isEmpty
                ? 'No recipes found'
                : '${filtered.length} recipe${filtered.length == 1 ? '' : 's'}${_query.isNotEmpty ? ' for "$_query"' : ' for children'}',
            style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  const Icon(Icons.search_off_rounded, size: 40, color: AppTheme.textTertiary),
                  const SizedBox(height: 12),
                  Text(
                    'No recipes match "$_query"',
                    style: const TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          else
            ...filtered.map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _RecipeCard(
                  title: r.title,
                  description: r.description,
                  prepTime: r.prepTime,
                  difficulty: r.difficulty,
                  calories: r.calories,
                  icon: r.icon,
                  color: r.color,
                  bgColor: r.bgColor,
                  onTap: () => Navigator.pushNamed(context, '/nutrition/recipe'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.description,
    required this.prepTime,
    required this.difficulty,
    required this.calories,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });

  final String title;
  final String description;
  final String prepTime;
  final String difficulty;
  final String calories;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 14),
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
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _StatChip(icon: Icons.schedule_rounded, label: prepTime),
                      const SizedBox(width: 8),
                      _StatChip(icon: Icons.local_fire_department_rounded, label: calories),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textTertiary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppTheme.textTertiary),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.textTertiary),
        ),
      ],
    );
  }
}
