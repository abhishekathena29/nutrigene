import 'package:flutter/material.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  String _selectedDay = 'Monday';

  final Map<String, Map<String, String>> _mealPlans = {
    'Monday': {
      'Breakfast': 'Oatmeal with banana and honey',
      'Mid-Morning': 'Apple slices with peanut butter',
      'Lunch': 'Rice with lentils and spinach curry',
      'Afternoon': 'Yogurt with berries',
      'Dinner': 'Chicken soup with vegetables',
    },
    'Tuesday': {
      'Breakfast': 'Whole wheat toast with eggs',
      'Mid-Morning': 'Orange and nuts',
      'Lunch': 'Chapati with vegetable curry',
      'Afternoon': 'Milk and cookies',
      'Dinner': 'Fish with mashed potatoes',
    },
    'Wednesday': {
      'Breakfast': 'Pancakes with fruit',
      'Mid-Morning': 'Carrot sticks with hummus',
      'Lunch': 'Rice bowl with beans and avocado',
      'Afternoon': 'Smoothie with spinach',
      'Dinner': 'Pasta with tomato sauce',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Plans')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.green.shade50,
              padding: const EdgeInsets.all(16.0),
              child: const Row(
                children: [
                  Icon(Icons.restaurant_menu, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Personalized meal plans for optimal nutrition',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Day Selector
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday',
                ].map((day) => _buildDayChip(day)).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Meal Plan for Selected Day
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meal Plan for $_selectedDay',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_mealPlans.containsKey(_selectedDay)) ...[
                    _buildMealCard(
                      'Breakfast',
                      _mealPlans[_selectedDay]!['Breakfast']!,
                      '7:00 AM',
                      Icons.wb_sunny,
                      Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Mid-Morning Snack',
                      _mealPlans[_selectedDay]!['Mid-Morning']!,
                      '10:00 AM',
                      Icons.coffee,
                      Colors.brown,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Lunch',
                      _mealPlans[_selectedDay]!['Lunch']!,
                      '12:30 PM',
                      Icons.lunch_dining,
                      Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Afternoon Snack',
                      _mealPlans[_selectedDay]!['Afternoon']!,
                      '3:30 PM',
                      Icons.icecream,
                      Colors.pink,
                    ),
                    const SizedBox(height: 12),
                    _buildMealCard(
                      'Dinner',
                      _mealPlans[_selectedDay]!['Dinner']!,
                      '7:00 PM',
                      Icons.dinner_dining,
                      Colors.blue,
                    ),
                  ] else
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Text(
                            'Meal plan coming soon for this day!',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lightbulb, color: Colors.blue),
                              SizedBox(width: 12),
                              Text(
                                'Nutrition Tip',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Include a variety of colors in meals to ensure diverse nutrients. Each color represents different vitamins and minerals!',
                            style: TextStyle(color: Colors.blue),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Generating custom meal plan...')),
          );
        },
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Generate Custom Plan'),
      ),
    );
  }

  Widget _buildDayChip(String day) {
    final bool isSelected = day == _selectedDay;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(day),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedDay = day;
            });
          }
        },
        selectedColor: Theme.of(context).colorScheme.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildMealCard(
    String mealType,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
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
                  Row(
                    children: [
                      Text(
                        mealType,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Edit $mealType meal')));
              },
            ),
          ],
        ),
      ),
    );
  }
}

