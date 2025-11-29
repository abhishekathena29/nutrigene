import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/dashboard/dashboard_page.dart';
import 'package:nutritrack/features/children/children_page.dart';
import 'package:nutritrack/features/children/child_form_page.dart';
import 'package:nutritrack/features/children/child_detail_page.dart';
import 'package:nutritrack/features/children/growth_input_page.dart';
import 'package:nutritrack/features/children/growth_chart_page.dart';
import 'package:nutritrack/features/children/epigenetic_risk_page.dart';
import 'package:nutritrack/features/children/caregiver_report_page.dart';
import 'package:nutritrack/features/nutrition/nutrition_page.dart';
import 'package:nutritrack/features/nutrition/food_access_page.dart';
import 'package:nutritrack/features/nutrition/meal_plan_page.dart';
import 'package:nutritrack/features/nutrition/recipes_list_page.dart';
import 'package:nutritrack/features/nutrition/recipe_detail_page.dart';
import 'package:nutritrack/features/nutrition/symptoms_checker_page.dart';
import 'package:nutritrack/features/brain/brain_module_page.dart';
import 'package:nutritrack/features/brain/brain_overview_page.dart';
import 'package:nutritrack/features/brain/brain_activities_page.dart';
import 'package:nutritrack/features/brain/brain_nutrition_tips_page.dart';
import 'package:nutritrack/features/more/more_page.dart';
import 'package:nutritrack/features/ngo/ngo_dashboard_page.dart';
import 'package:nutritrack/features/common/alerts_page.dart';
import 'package:nutritrack/features/common/settings_page.dart';
import 'package:nutritrack/features/common/about_page.dart';

class NutriGeneApp extends StatelessWidget {
  const NutriGeneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriGene',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavigationPage(),

        // Children routes
        '/child/form': (context) => const ChildFormPage(),
        '/child/details': (context) => const ChildDetailPage(),
        '/child/growth-input': (context) => const GrowthInputPage(),
        '/child/growth-chart': (context) => const GrowthChartPage(),
        '/child/epigenetic': (context) => const EpigeneticRiskPage(),
        '/child/report': (context) => const CaregiverReportPage(),

        // Nutrition routes
        '/nutrition/access': (context) => const FoodAccessPage(),
        '/nutrition/meal-plan': (context) => const MealPlanPage(),
        '/nutrition/recipes': (context) => const RecipesListPage(),
        '/nutrition/recipe': (context) => const RecipeDetailPage(),
        '/nutrition/symptoms': (context) => const SymptomsCheckerPage(),

        // Brain routes
        '/brain/overview': (context) => const BrainOverviewPage(),
        '/brain/activities': (context) => const BrainActivitiesPage(),
        '/brain/nutrition-tips': (context) => const BrainNutritionTipsPage(),

        // Other routes
        '/ngo/dashboard': (context) => const NgoDashboardPage(),
        '/alerts': (context) => const AlertsPage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const ChildrenPage(),
    const NutritionPage(),
    const BrainModulePage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care),
            label: 'Children',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'Brain'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

