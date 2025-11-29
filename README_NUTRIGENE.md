# NutriGene - AI-Powered Nutrition Tracker

NutriGene is a comprehensive Flutter application designed to combat child malnutrition through personalized nutrition recommendations, growth monitoring, and early intervention.

## Features

### 📊 Dashboard
- Overview of key metrics and alerts
- Quick access to important actions
- Summary statistics for tracked children

### 👶 Children Management
- **Child Profiles**: Add and manage multiple children profiles
- **Growth Tracking**: Monitor height, weight, MUAC (Mid-Upper Arm Circumference)
- **Growth Charts**: WHO-standard growth charts visualization
- **Epigenetic Risk Assessment**: Early detection of nutritional deficiencies
- **Caregiver Reports**: Comprehensive health and nutrition reports

### 🍎 Nutrition
- **Food Access & Affordability**: Browse affordable food options
- **Meal Plans**: Personalized daily and weekly meal suggestions
- **Recipes**: Nutritious recipes designed for children
- **Symptoms Checker**: Identify potential nutritional deficiencies

### 🧠 Brain Development
- **Development Overview**: Learn about brain development stages
- **Activities**: Age-appropriate cognitive development activities
- **Nutrition Tips**: Essential nutrients for brain health

### 🏢 NGO Support
- Bulk management for organizations
- Multi-location child tracking
- Bulk reporting and data export

### ⚙️ Settings & More
- Multi-language support
- Unit preferences (Metric/Imperial)
- Data backup and export
- About and help resources

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # Main app configuration with routing
├── core/
│   └── theme/
│       └── app_theme.dart    # App-wide theme configuration
└── features/
    ├── dashboard/
    │   └── dashboard_page.dart
    ├── children/
    │   ├── children_page.dart
    │   ├── child_form_page.dart
    │   ├── child_detail_page.dart
    │   ├── growth_input_page.dart
    │   ├── growth_chart_page.dart
    │   ├── epigenetic_risk_page.dart
    │   └── caregiver_report_page.dart
    ├── nutrition/
    │   ├── nutrition_page.dart
    │   ├── food_access_page.dart
    │   ├── meal_plan_page.dart
    │   ├── recipes_list_page.dart
    │   ├── recipe_detail_page.dart
    │   └── symptoms_checker_page.dart
    ├── brain/
    │   ├── brain_module_page.dart
    │   ├── brain_overview_page.dart
    │   ├── brain_activities_page.dart
    │   └── brain_nutrition_tips_page.dart
    ├── more/
    │   └── more_page.dart
    ├── ngo/
    │   └── ngo_dashboard_page.dart
    └── common/
        ├── alerts_page.dart
        ├── settings_page.dart
        └── about_page.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (>= 3.8.1)
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd nutritrack
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Routes

The app uses named routes for navigation:

### Children Routes
- `/child/form` - Add/Edit child profile
- `/child/details` - View child details
- `/child/growth-input` - Input growth measurements
- `/child/growth-chart` - View WHO growth charts
- `/child/epigenetic` - Epigenetic risk assessment
- `/child/report` - Generate caregiver reports

### Nutrition Routes
- `/nutrition/access` - Food access and affordability
- `/nutrition/meal-plan` - View meal plans
- `/nutrition/recipes` - Browse recipes
- `/nutrition/recipe` - Recipe details
- `/nutrition/symptoms` - Symptoms checker

### Brain Routes
- `/brain/overview` - Brain development overview
- `/brain/activities` - Brain-boosting activities
- `/brain/nutrition-tips` - Brain nutrition tips

### Other Routes
- `/ngo/dashboard` - NGO dashboard
- `/alerts` - View alerts
- `/settings` - App settings
- `/about` - About NutriGene

## Design System

### Color Palette
- **Primary**: Green (#4CAF50) - Represents nutrition and health
- **Secondary**: Orange (#FF9800) - Accent color for highlights
- **Accent**: Blue (#2196F3) - Supporting actions
- **Error**: Red (#E53935) - Alerts and warnings
- **Success**: Green (#43A047) - Positive indicators

### Typography
- Material Design 3 typography system
- Clear hierarchy for readability

### Components
- Material Design 3 components
- Custom card designs for better content organization
- Consistent spacing and padding

## Features in Development

This is a foundational implementation with placeholder content. Future enhancements include:

- Real WHO growth chart integration
- AI-powered nutrition recommendations
- Offline data synchronization
- Multi-language localization
- Photo-based food logging
- Integration with wearable devices
- Advanced analytics and insights

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- WHO Growth Standards
- Flutter and Dart teams
- The global nutrition community

## Contact

For questions or support, please contact: support@nutrigene.org

---

**Made with ❤️ for children worldwide**


