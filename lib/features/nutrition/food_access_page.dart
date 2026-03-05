import 'package:flutter/material.dart';

class FoodAccessPage extends StatelessWidget {
  const FoodAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Access & Affordability')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Find affordable and nutritious food options',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Food Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFoodCategoryCard(
              icon: Icons.grass,
              title: 'Vegetables',
              items: 'Spinach, Carrots, Tomatoes',
              priceRange: '₹20–60/kg',
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            _buildFoodCategoryCard(
              icon: Icons.apple,
              title: 'Fruits',
              items: 'Bananas, Apples, Oranges',
              priceRange: '₹40–120/kg',
              color: Colors.orange,
            ),
            const SizedBox(height: 8),
            _buildFoodCategoryCard(
              icon: Icons.set_meal,
              title: 'Proteins',
              items: 'Eggs, Lentils, Chicken',
              priceRange: '₹80–250/kg',
              color: Colors.red,
            ),
            const SizedBox(height: 8),
            _buildFoodCategoryCard(
              icon: Icons.rice_bowl,
              title: 'Grains',
              items: 'Rice, Wheat, Oats',
              priceRange: '₹30–80/kg',
              color: Colors.brown,
            ),
            const SizedBox(height: 8),
            _buildFoodCategoryCard(
              icon: Icons.water_drop,
              title: 'Dairy',
              items: 'Milk, Yogurt, Cheese',
              priceRange: '₹50–200/L',
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Affordable Meal Bundles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildMealBundleCard(
              title: 'Daily Essentials Bundle',
              description: 'Rice, Lentils, Vegetables, Cooking Oil',
              price: '₹350',
              servings: '4–5 meals',
            ),
            const SizedBox(height: 8),
            _buildMealBundleCard(
              title: 'Protein Pack',
              description: 'Eggs, Chicken, Beans, Milk',
              price: '₹500',
              servings: '6–7 meals',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCategoryCard({
    required IconData icon,
    required String title,
    required String items,
    required String priceRange,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              priceRange,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealBundleCard({
    required String title,
    required String description,
    required String price,
    required String servings,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.restaurant, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  servings,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
