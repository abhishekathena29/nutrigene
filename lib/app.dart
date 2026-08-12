import 'package:flutter/material.dart';
import 'package:nutritrack/core/locale/locale_provider.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/core/theme/theme_provider.dart';
import 'package:nutritrack/l10n/app_localizations.dart';
import 'package:nutritrack/features/auth/login_page.dart';
import 'package:nutritrack/features/auth/onboarding_page.dart';
import 'package:nutritrack/features/auth/provider/auth_provider.dart';
import 'package:nutritrack/features/auth/signup_page.dart';
import 'package:nutritrack/features/dashboard/dashboard_page.dart';
import 'package:nutritrack/features/children/children_page.dart';
import 'package:nutritrack/features/children/child_detail_page.dart';
import 'package:nutritrack/features/children/child_form_page.dart';
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
import 'package:nutritrack/features/common/sources_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class NutriGeneApp extends StatelessWidget {
  const NutriGeneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    return MaterialApp(
      title: 'NutriGene',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/home': (context) => const MainNavigationPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),

        // Children routes
        '/children': (context) => const ChildrenPage(),
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
        '/sources': (context) => const SourcesPage(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenProvider>(
      builder: (context, auth, _) {
        return StreamBuilder<User?>(
          stream: auth.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData) {
              return const MainNavigationPage();
            }
            return const OnboardingPage();
          },
        );
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: _PageContainer(
            key: ValueKey(_currentIndex),
            child: _pages[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard_rounded),
            label: l10n.navDashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.child_care_outlined),
            selectedIcon: const Icon(Icons.child_care_rounded),
            label: l10n.navChildren,
          ),
          NavigationDestination(
            icon: const Icon(Icons.restaurant_menu_outlined),
            selectedIcon: const Icon(Icons.restaurant_menu_rounded),
            label: l10n.navNutrition,
          ),
          NavigationDestination(
            icon: const Icon(Icons.psychology_outlined),
            selectedIcon: const Icon(Icons.psychology_rounded),
            label: l10n.navBrain,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_horiz_rounded),
            selectedIcon: const Icon(Icons.more_rounded),
            label: l10n.navMore,
          ),
        ],
      ),
    );
  }
}

class _PageContainer extends StatelessWidget {
  const _PageContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
