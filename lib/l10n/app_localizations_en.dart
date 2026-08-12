// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navChildren => 'Children';

  @override
  String get navNutrition => 'Nutrition';

  @override
  String get navBrain => 'Brain';

  @override
  String get navMore => 'More';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSave => 'Save';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonAdd => 'Add';

  @override
  String get dashboardGreeting => 'Good morning,\nNutriGuardian';

  @override
  String get dashboardTagline =>
      'AI-curated insights are ready. Keep your little ones thriving.';

  @override
  String get dashboardWellnessLogged => 'Wellness logged';

  @override
  String get dashboardMealsPlanned => 'Meals planned';

  @override
  String get dashboardViewTodaysFocus => 'View today\'s focus';

  @override
  String get dashboardTodaysSnapshot => 'Today\'s Snapshot';

  @override
  String get dashboardViewAll => 'View all';

  @override
  String get dashboardMealsLabel => 'Meals';

  @override
  String get dashboardActivitiesLabel => 'Activities';

  @override
  String get dashboardTodaysMeals => 'Today\'s meals';

  @override
  String get dashboardNoMealsPlanned => 'No meals planned for today';

  @override
  String get dashboardKeyAlerts => 'Key Alerts';

  @override
  String get dashboardAllCaughtUp => 'You\'re all caught up — no alerts.';

  @override
  String get dashboardQuickActions => 'Quick Actions';

  @override
  String get dashboardMealPlansAction => 'Meal Plans';

  @override
  String get dashboardBrainTipsAction => 'Brain Tips';

  @override
  String get dashboardGrowthAction => 'Growth';

  @override
  String get childrenAddedMessage => 'Child profile added.';

  @override
  String get childrenUpdatedMessage => 'Child profile updated.';

  @override
  String childrenProfileCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count profiles',
      one: '$count profile',
    );
    return '$_temp0';
  }

  @override
  String get childrenNoneYetTitle => 'No children yet';

  @override
  String get childrenNoneYetSubtitle =>
      'Add a child profile to start\ntracking their growth and nutrition.';

  @override
  String get childrenAddFirst => 'Add first child';

  @override
  String get childrenDeleteTitle => 'Delete profile?';

  @override
  String childrenDeleteConfirm(Object name) {
    return 'Remove $name\'s profile permanently? This cannot be undone.';
  }

  @override
  String childrenDeletedMessage(Object name) {
    return '$name deleted.';
  }

  @override
  String get childrenDeleteFailed => 'Failed to delete. Try again.';

  @override
  String childrenGuardianLabel(Object name) {
    return 'Guardian: $name';
  }

  @override
  String get nutritionHubTitle => 'Nutrition Hub';

  @override
  String get nutritionHubSubtitle =>
      'Meal plans, recipes, and nutritional insights.';

  @override
  String get nutritionExploreLabel => 'EXPLORE';

  @override
  String get nutritionFoodAccessTitle => 'Food Access & Affordability';

  @override
  String get nutritionFoodAccessDesc =>
      'Nutritious options at affordable prices';

  @override
  String get nutritionMealPlansDesc => 'AI-powered weekly meal suggestions';

  @override
  String get nutritionRecipesTitle => 'Recipes';

  @override
  String get nutritionRecipesDesc => 'Nutritious recipes designed for children';

  @override
  String get nutritionSymptomsTitle => 'Symptoms Checker';

  @override
  String get nutritionSymptomsDesc => 'Check for nutritional deficiencies';

  @override
  String get mealPlanTitle => 'Meal Plans';

  @override
  String get mealPlanDeletePlanTooltip => 'Delete plan';

  @override
  String get mealPlanAiGenerate => 'AI Generate';

  @override
  String get mealPlanNoPlanTitle => 'No meal plan for this day';

  @override
  String get mealPlanNoPlanSubtitle =>
      'Generate an AI-powered plan or create one manually.';

  @override
  String get mealPlanGenerateWithAi => 'Generate with AI';

  @override
  String get mealPlanCreateManually => 'Create manually';

  @override
  String get mealPlanNotSet => 'Not set — tap to add';

  @override
  String get mealPlanChildAgeLabel => 'Child age';

  @override
  String get mealPlanChildAgeHint => 'e.g. 5 years';

  @override
  String get mealPlanPreferencesLabel => 'Preferences or restrictions';

  @override
  String get mealPlanPreferencesHint => 'e.g. vegetarian, no nuts';

  @override
  String get mealPlanGenerateAction => 'Generate';

  @override
  String get mealPlanSavedMessage => 'Meal plan saved';

  @override
  String mealPlanCreateForDay(Object day) {
    return 'Create plan for $day';
  }

  @override
  String get mealPlanNoteLabel => 'Note (optional)';

  @override
  String mealPlanEditTitle(Object mealType) {
    return 'Edit $mealType';
  }

  @override
  String get mealPlanDescriptionLabel => 'Meal description';

  @override
  String mealPlanUpdatedMessage(Object mealType) {
    return '$mealType updated';
  }

  @override
  String get mealPlanDeleteConfirmTitle => 'Delete meal plan?';

  @override
  String mealPlanDeleteConfirmBody(Object day) {
    return 'Remove meal plan for $day?';
  }

  @override
  String get mealPlanDeletedMessage => 'Meal plan deleted';

  @override
  String get mealBreakfast => 'Breakfast';

  @override
  String get mealMidMorning => 'Mid-Morning';

  @override
  String get mealLunch => 'Lunch';

  @override
  String get mealAfternoon => 'Afternoon';

  @override
  String get mealDinner => 'Dinner';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';

  @override
  String get moreTitle => 'Profile';

  @override
  String get moreVerified => 'Verified';

  @override
  String get moreNotVerified => 'Not verified';

  @override
  String get moreNameLabel => 'Name';

  @override
  String get moreEmailLabel => 'Email';

  @override
  String get moreNgoDashboard => 'NGO Dashboard';

  @override
  String get moreSettings => 'Settings';

  @override
  String get moreAboutNutriGene => 'About NutriGene';

  @override
  String get moreSourcesReferences => 'Sources & References';

  @override
  String get moreSignOutTitle => 'Sign out?';

  @override
  String get moreSignOutBody => 'You will be returned to the login screen.';

  @override
  String get moreSignOutAction => 'Sign out';

  @override
  String get moreDeleteAccountTitle => 'Delete account?';

  @override
  String get moreDeleteAccountBody =>
      'This will permanently delete your account and cannot be undone. All associated data will be lost.';

  @override
  String get moreDeleteAccountAction => 'Delete Account';

  @override
  String get settingsGeneralSection => 'General';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsDesc => 'Receive alerts and reminders';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeDesc => 'Use dark theme';

  @override
  String get settingsLanguageSection => 'Language & Region';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsDataPrivacySection => 'Data & Privacy';

  @override
  String get settingsBackupData => 'Backup Data';

  @override
  String get settingsBackupDataValue => 'Save to cloud';

  @override
  String get settingsBackingUp => 'Backing up data...';

  @override
  String get settingsExportData => 'Export Data';

  @override
  String get settingsExportDataValue => 'Download your data';

  @override
  String get settingsExporting => 'Exporting data...';

  @override
  String get settingsClearAllData => 'Clear All Data';

  @override
  String get settingsClearAllDataValue => 'Permanently delete';

  @override
  String get settingsClearDataTitle => 'Clear All Data?';

  @override
  String get settingsClearDataBody =>
      'This will permanently delete all data. This action cannot be undone.';

  @override
  String get settingsDataCleared => 'Data cleared successfully';

  @override
  String get settingsClearAction => 'Clear';

  @override
  String get settingsSupportSection => 'Support';

  @override
  String get settingsHelpCenter => 'Help Center';

  @override
  String get settingsOpeningHelp => 'Opening help center...';

  @override
  String get settingsSendFeedback => 'Send Feedback';

  @override
  String get settingsOpeningFeedback => 'Opening feedback form...';

  @override
  String get settingsReportBug => 'Report a Bug';

  @override
  String get settingsOpeningBugReport => 'Opening bug report...';

  @override
  String get loginPleaseEnterCreds => 'Please enter your email and password.';

  @override
  String get loginEnterEmailToReset =>
      'Enter your email to reset your password.';

  @override
  String loginResetLinkSent(Object email) {
    return 'Password reset link sent to $email.';
  }

  @override
  String get loginWelcomeBack => 'Welcome\nback';

  @override
  String get loginSubtitle =>
      'Sign in to continue tracking and supporting healthy growth.';

  @override
  String get loginEmailLabel => 'Email address';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginSignInAction => 'Sign in';

  @override
  String get loginOrDivider => 'or';

  @override
  String get loginContinueWithGoogle => 'Continue with Google';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginSignUpLink => 'Sign up';

  @override
  String get signupPleaseComplete => 'Please complete all required fields.';

  @override
  String get signupPasswordsMismatch => 'Passwords do not match.';

  @override
  String get signupCreateAccountHeader => 'Create your\naccount';

  @override
  String get signupSubtitle =>
      'Join NutriGene and start supporting children\'s health today.';

  @override
  String get signupFullNameLabel => 'Full name';

  @override
  String get signupFirstNameHint => 'First name';

  @override
  String get signupLastNameHint => 'Last name';

  @override
  String get signupPasswordHint => 'Min. 8 characters';

  @override
  String get signupConfirmPasswordLabel => 'Confirm password';

  @override
  String get signupConfirmPasswordHint => 'Repeat your password';

  @override
  String get signupCreateAccountAction => 'Create account';

  @override
  String get signupTerms =>
      'By creating an account, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get signupAlreadyHaveAccount => 'Already have an account?';

  @override
  String get aboutVersion => 'Version 1.0.0';

  @override
  String get aboutOurMission => 'Our Mission';

  @override
  String get aboutMissionBody =>
      'NutriGene is an AI-powered nutrition tracker and assistant designed to combat child malnutrition through personalized nutrition recommendations, growth monitoring, and early intervention.';

  @override
  String get aboutKeyFeatures => 'Key Features';

  @override
  String get aboutFeatureGrowthTitle => 'Growth Tracking';

  @override
  String get aboutFeatureGrowthDesc =>
      'Monitor children\'s growth using WHO standards';

  @override
  String get aboutFeatureAiTitle => 'AI Recommendations';

  @override
  String get aboutFeatureAiDesc =>
      'Personalized nutrition advice powered by AI';

  @override
  String get aboutFeatureEpigeneticTitle => 'Epigenetic Risk Assessment';

  @override
  String get aboutFeatureEpigeneticDesc =>
      'Early detection of nutritional deficiencies';

  @override
  String get aboutFeatureBrainTitle => 'Brain Development';

  @override
  String get aboutFeatureBrainDesc =>
      'Activities and nutrition tips for cognitive growth';

  @override
  String get aboutFeatureNgoTitle => 'NGO Support';

  @override
  String get aboutFeatureNgoDesc =>
      'Tools for organizations managing multiple children';

  @override
  String get aboutImpactTitle => 'Together, we can end child malnutrition';

  @override
  String get aboutImpactBody =>
      'NutriGene is expanding its reach to help NGOs, caregivers, and health workers monitor child growth, combat malnutrition, and provide actionable AI insights worldwide.';

  @override
  String get aboutGetInTouch => 'Get in Touch';

  @override
  String get aboutWebsiteLabel => 'Website';

  @override
  String get aboutSocialMediaLabel => 'Social Media';

  @override
  String get aboutSocialMediaValue => 'Follow us on social platforms';

  @override
  String get aboutMedicalInfo => 'Medical Information';

  @override
  String get aboutCopyright => '© 2025 NutriGene. All rights reserved.';
}
