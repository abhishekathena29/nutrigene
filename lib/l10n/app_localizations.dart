import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navChildren.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get navChildren;

  /// No description provided for @navNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get navNutrition;

  /// No description provided for @navBrain.
  ///
  /// In en, this message translates to:
  /// **'Brain'**
  String get navBrain;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @dashboardGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning,\nNutriGuardian'**
  String get dashboardGreeting;

  /// No description provided for @dashboardTagline.
  ///
  /// In en, this message translates to:
  /// **'AI-curated insights are ready. Keep your little ones thriving.'**
  String get dashboardTagline;

  /// No description provided for @dashboardWellnessLogged.
  ///
  /// In en, this message translates to:
  /// **'Wellness logged'**
  String get dashboardWellnessLogged;

  /// No description provided for @dashboardMealsPlanned.
  ///
  /// In en, this message translates to:
  /// **'Meals planned'**
  String get dashboardMealsPlanned;

  /// No description provided for @dashboardViewTodaysFocus.
  ///
  /// In en, this message translates to:
  /// **'View today\'s focus'**
  String get dashboardViewTodaysFocus;

  /// No description provided for @dashboardTodaysSnapshot.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Snapshot'**
  String get dashboardTodaysSnapshot;

  /// No description provided for @dashboardViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get dashboardViewAll;

  /// No description provided for @dashboardMealsLabel.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get dashboardMealsLabel;

  /// No description provided for @dashboardActivitiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get dashboardActivitiesLabel;

  /// No description provided for @dashboardTodaysMeals.
  ///
  /// In en, this message translates to:
  /// **'Today\'s meals'**
  String get dashboardTodaysMeals;

  /// No description provided for @dashboardNoMealsPlanned.
  ///
  /// In en, this message translates to:
  /// **'No meals planned for today'**
  String get dashboardNoMealsPlanned;

  /// No description provided for @dashboardKeyAlerts.
  ///
  /// In en, this message translates to:
  /// **'Key Alerts'**
  String get dashboardKeyAlerts;

  /// No description provided for @dashboardAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up — no alerts.'**
  String get dashboardAllCaughtUp;

  /// No description provided for @dashboardQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get dashboardQuickActions;

  /// No description provided for @dashboardMealPlansAction.
  ///
  /// In en, this message translates to:
  /// **'Meal Plans'**
  String get dashboardMealPlansAction;

  /// No description provided for @dashboardBrainTipsAction.
  ///
  /// In en, this message translates to:
  /// **'Brain Tips'**
  String get dashboardBrainTipsAction;

  /// No description provided for @dashboardGrowthAction.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get dashboardGrowthAction;

  /// No description provided for @childrenAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'Child profile added.'**
  String get childrenAddedMessage;

  /// No description provided for @childrenUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Child profile updated.'**
  String get childrenUpdatedMessage;

  /// No description provided for @childrenProfileCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} profile} other{{count} profiles}}'**
  String childrenProfileCount(num count);

  /// No description provided for @childrenNoneYetTitle.
  ///
  /// In en, this message translates to:
  /// **'No children yet'**
  String get childrenNoneYetTitle;

  /// No description provided for @childrenNoneYetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a child profile to start\ntracking their growth and nutrition.'**
  String get childrenNoneYetSubtitle;

  /// No description provided for @childrenAddFirst.
  ///
  /// In en, this message translates to:
  /// **'Add first child'**
  String get childrenAddFirst;

  /// No description provided for @childrenDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete profile?'**
  String get childrenDeleteTitle;

  /// No description provided for @childrenDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}\'s profile permanently? This cannot be undone.'**
  String childrenDeleteConfirm(Object name);

  /// No description provided for @childrenDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted.'**
  String childrenDeletedMessage(Object name);

  /// No description provided for @childrenDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete. Try again.'**
  String get childrenDeleteFailed;

  /// No description provided for @childrenGuardianLabel.
  ///
  /// In en, this message translates to:
  /// **'Guardian: {name}'**
  String childrenGuardianLabel(Object name);

  /// No description provided for @nutritionHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Hub'**
  String get nutritionHubTitle;

  /// No description provided for @nutritionHubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Meal plans, recipes, and nutritional insights.'**
  String get nutritionHubSubtitle;

  /// No description provided for @nutritionExploreLabel.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE'**
  String get nutritionExploreLabel;

  /// No description provided for @nutritionFoodAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Access & Affordability'**
  String get nutritionFoodAccessTitle;

  /// No description provided for @nutritionFoodAccessDesc.
  ///
  /// In en, this message translates to:
  /// **'Nutritious options at affordable prices'**
  String get nutritionFoodAccessDesc;

  /// No description provided for @nutritionMealPlansDesc.
  ///
  /// In en, this message translates to:
  /// **'AI-powered weekly meal suggestions'**
  String get nutritionMealPlansDesc;

  /// No description provided for @nutritionRecipesTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get nutritionRecipesTitle;

  /// No description provided for @nutritionRecipesDesc.
  ///
  /// In en, this message translates to:
  /// **'Nutritious recipes designed for children'**
  String get nutritionRecipesDesc;

  /// No description provided for @nutritionSymptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms Checker'**
  String get nutritionSymptomsTitle;

  /// No description provided for @nutritionSymptomsDesc.
  ///
  /// In en, this message translates to:
  /// **'Check for nutritional deficiencies'**
  String get nutritionSymptomsDesc;

  /// No description provided for @mealPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Meal Plans'**
  String get mealPlanTitle;

  /// No description provided for @mealPlanDeletePlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete plan'**
  String get mealPlanDeletePlanTooltip;

  /// No description provided for @mealPlanAiGenerate.
  ///
  /// In en, this message translates to:
  /// **'AI Generate'**
  String get mealPlanAiGenerate;

  /// No description provided for @mealPlanNoPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'No meal plan for this day'**
  String get mealPlanNoPlanTitle;

  /// No description provided for @mealPlanNoPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate an AI-powered plan or create one manually.'**
  String get mealPlanNoPlanSubtitle;

  /// No description provided for @mealPlanGenerateWithAi.
  ///
  /// In en, this message translates to:
  /// **'Generate with AI'**
  String get mealPlanGenerateWithAi;

  /// No description provided for @mealPlanCreateManually.
  ///
  /// In en, this message translates to:
  /// **'Create manually'**
  String get mealPlanCreateManually;

  /// No description provided for @mealPlanNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set — tap to add'**
  String get mealPlanNotSet;

  /// No description provided for @mealPlanChildAgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Child age'**
  String get mealPlanChildAgeLabel;

  /// No description provided for @mealPlanChildAgeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 5 years'**
  String get mealPlanChildAgeHint;

  /// No description provided for @mealPlanPreferencesLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferences or restrictions'**
  String get mealPlanPreferencesLabel;

  /// No description provided for @mealPlanPreferencesHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. vegetarian, no nuts'**
  String get mealPlanPreferencesHint;

  /// No description provided for @mealPlanGenerateAction.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get mealPlanGenerateAction;

  /// No description provided for @mealPlanSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Meal plan saved'**
  String get mealPlanSavedMessage;

  /// No description provided for @mealPlanCreateForDay.
  ///
  /// In en, this message translates to:
  /// **'Create plan for {day}'**
  String mealPlanCreateForDay(Object day);

  /// No description provided for @mealPlanNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get mealPlanNoteLabel;

  /// No description provided for @mealPlanEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit {mealType}'**
  String mealPlanEditTitle(Object mealType);

  /// No description provided for @mealPlanDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Meal description'**
  String get mealPlanDescriptionLabel;

  /// No description provided for @mealPlanUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'{mealType} updated'**
  String mealPlanUpdatedMessage(Object mealType);

  /// No description provided for @mealPlanDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete meal plan?'**
  String get mealPlanDeleteConfirmTitle;

  /// No description provided for @mealPlanDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Remove meal plan for {day}?'**
  String mealPlanDeleteConfirmBody(Object day);

  /// No description provided for @mealPlanDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Meal plan deleted'**
  String get mealPlanDeletedMessage;

  /// No description provided for @mealBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealBreakfast;

  /// No description provided for @mealMidMorning.
  ///
  /// In en, this message translates to:
  /// **'Mid-Morning'**
  String get mealMidMorning;

  /// No description provided for @mealLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealLunch;

  /// No description provided for @mealAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get mealAfternoon;

  /// No description provided for @mealDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealDinner;

  /// No description provided for @dayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;

  /// No description provided for @moreTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get moreTitle;

  /// No description provided for @moreVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get moreVerified;

  /// No description provided for @moreNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get moreNotVerified;

  /// No description provided for @moreNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get moreNameLabel;

  /// No description provided for @moreEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get moreEmailLabel;

  /// No description provided for @moreNgoDashboard.
  ///
  /// In en, this message translates to:
  /// **'NGO Dashboard'**
  String get moreNgoDashboard;

  /// No description provided for @moreSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get moreSettings;

  /// No description provided for @moreAboutNutriGene.
  ///
  /// In en, this message translates to:
  /// **'About NutriGene'**
  String get moreAboutNutriGene;

  /// No description provided for @moreSourcesReferences.
  ///
  /// In en, this message translates to:
  /// **'Sources & References'**
  String get moreSourcesReferences;

  /// No description provided for @moreSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get moreSignOutTitle;

  /// No description provided for @moreSignOutBody.
  ///
  /// In en, this message translates to:
  /// **'You will be returned to the login screen.'**
  String get moreSignOutBody;

  /// No description provided for @moreSignOutAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get moreSignOutAction;

  /// No description provided for @moreDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get moreDeleteAccountTitle;

  /// No description provided for @moreDeleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and cannot be undone. All associated data will be lost.'**
  String get moreDeleteAccountBody;

  /// No description provided for @moreDeleteAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get moreDeleteAccountAction;

  /// No description provided for @settingsGeneralSection.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneralSection;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive alerts and reminders'**
  String get settingsNotificationsDesc;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeDesc.
  ///
  /// In en, this message translates to:
  /// **'Use dark theme'**
  String get settingsDarkModeDesc;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get settingsLanguageSection;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsSelectLanguage;

  /// No description provided for @settingsDataPrivacySection.
  ///
  /// In en, this message translates to:
  /// **'Data & Privacy'**
  String get settingsDataPrivacySection;

  /// No description provided for @settingsBackupData.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get settingsBackupData;

  /// No description provided for @settingsBackupDataValue.
  ///
  /// In en, this message translates to:
  /// **'Save to cloud'**
  String get settingsBackupDataValue;

  /// No description provided for @settingsBackingUp.
  ///
  /// In en, this message translates to:
  /// **'Backing up data...'**
  String get settingsBackingUp;

  /// No description provided for @settingsExportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settingsExportData;

  /// No description provided for @settingsExportDataValue.
  ///
  /// In en, this message translates to:
  /// **'Download your data'**
  String get settingsExportDataValue;

  /// No description provided for @settingsExporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting data...'**
  String get settingsExporting;

  /// No description provided for @settingsClearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get settingsClearAllData;

  /// No description provided for @settingsClearAllDataValue.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete'**
  String get settingsClearAllDataValue;

  /// No description provided for @settingsClearDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data?'**
  String get settingsClearDataTitle;

  /// No description provided for @settingsClearDataBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all data. This action cannot be undone.'**
  String get settingsClearDataBody;

  /// No description provided for @settingsDataCleared.
  ///
  /// In en, this message translates to:
  /// **'Data cleared successfully'**
  String get settingsDataCleared;

  /// No description provided for @settingsClearAction.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsClearAction;

  /// No description provided for @settingsSupportSection.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupportSection;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsHelpCenter;

  /// No description provided for @settingsOpeningHelp.
  ///
  /// In en, this message translates to:
  /// **'Opening help center...'**
  String get settingsOpeningHelp;

  /// No description provided for @settingsSendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get settingsSendFeedback;

  /// No description provided for @settingsOpeningFeedback.
  ///
  /// In en, this message translates to:
  /// **'Opening feedback form...'**
  String get settingsOpeningFeedback;

  /// No description provided for @settingsReportBug.
  ///
  /// In en, this message translates to:
  /// **'Report a Bug'**
  String get settingsReportBug;

  /// No description provided for @settingsOpeningBugReport.
  ///
  /// In en, this message translates to:
  /// **'Opening bug report...'**
  String get settingsOpeningBugReport;

  /// No description provided for @loginPleaseEnterCreds.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password.'**
  String get loginPleaseEnterCreds;

  /// No description provided for @loginEnterEmailToReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password.'**
  String get loginEnterEmailToReset;

  /// No description provided for @loginResetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to {email}.'**
  String loginResetLinkSent(Object email);

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome\nback'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue tracking and supporting healthy growth.'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginSignInAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginSignInAction;

  /// No description provided for @loginOrDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get loginOrDivider;

  /// No description provided for @loginContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get loginContinueWithGoogle;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginSignUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get loginSignUpLink;

  /// No description provided for @signupPleaseComplete.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields.'**
  String get signupPleaseComplete;

  /// No description provided for @signupPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get signupPasswordsMismatch;

  /// No description provided for @signupCreateAccountHeader.
  ///
  /// In en, this message translates to:
  /// **'Create your\naccount'**
  String get signupCreateAccountHeader;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join NutriGene and start supporting children\'s health today.'**
  String get signupSubtitle;

  /// No description provided for @signupFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get signupFullNameLabel;

  /// No description provided for @signupFirstNameHint.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get signupFirstNameHint;

  /// No description provided for @signupLastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get signupLastNameHint;

  /// No description provided for @signupPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Min. 8 characters'**
  String get signupPasswordHint;

  /// No description provided for @signupConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get signupConfirmPasswordLabel;

  /// No description provided for @signupConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat your password'**
  String get signupConfirmPasswordHint;

  /// No description provided for @signupCreateAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signupCreateAccountAction;

  /// No description provided for @signupTerms.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to our Terms of Service and Privacy Policy.'**
  String get signupTerms;

  /// No description provided for @signupAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signupAlreadyHaveAccount;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersion;

  /// No description provided for @aboutOurMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get aboutOurMission;

  /// No description provided for @aboutMissionBody.
  ///
  /// In en, this message translates to:
  /// **'NutriGene is an AI-powered nutrition tracker and assistant designed to combat child malnutrition through personalized nutrition recommendations, growth monitoring, and early intervention.'**
  String get aboutMissionBody;

  /// No description provided for @aboutKeyFeatures.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get aboutKeyFeatures;

  /// No description provided for @aboutFeatureGrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'Growth Tracking'**
  String get aboutFeatureGrowthTitle;

  /// No description provided for @aboutFeatureGrowthDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor children\'s growth using WHO standards'**
  String get aboutFeatureGrowthDesc;

  /// No description provided for @aboutFeatureAiTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Recommendations'**
  String get aboutFeatureAiTitle;

  /// No description provided for @aboutFeatureAiDesc.
  ///
  /// In en, this message translates to:
  /// **'Personalized nutrition advice powered by AI'**
  String get aboutFeatureAiDesc;

  /// No description provided for @aboutFeatureEpigeneticTitle.
  ///
  /// In en, this message translates to:
  /// **'Epigenetic Risk Assessment'**
  String get aboutFeatureEpigeneticTitle;

  /// No description provided for @aboutFeatureEpigeneticDesc.
  ///
  /// In en, this message translates to:
  /// **'Early detection of nutritional deficiencies'**
  String get aboutFeatureEpigeneticDesc;

  /// No description provided for @aboutFeatureBrainTitle.
  ///
  /// In en, this message translates to:
  /// **'Brain Development'**
  String get aboutFeatureBrainTitle;

  /// No description provided for @aboutFeatureBrainDesc.
  ///
  /// In en, this message translates to:
  /// **'Activities and nutrition tips for cognitive growth'**
  String get aboutFeatureBrainDesc;

  /// No description provided for @aboutFeatureNgoTitle.
  ///
  /// In en, this message translates to:
  /// **'NGO Support'**
  String get aboutFeatureNgoTitle;

  /// No description provided for @aboutFeatureNgoDesc.
  ///
  /// In en, this message translates to:
  /// **'Tools for organizations managing multiple children'**
  String get aboutFeatureNgoDesc;

  /// No description provided for @aboutImpactTitle.
  ///
  /// In en, this message translates to:
  /// **'Together, we can end child malnutrition'**
  String get aboutImpactTitle;

  /// No description provided for @aboutImpactBody.
  ///
  /// In en, this message translates to:
  /// **'NutriGene is expanding its reach to help NGOs, caregivers, and health workers monitor child growth, combat malnutrition, and provide actionable AI insights worldwide.'**
  String get aboutImpactBody;

  /// No description provided for @aboutGetInTouch.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get aboutGetInTouch;

  /// No description provided for @aboutWebsiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get aboutWebsiteLabel;

  /// No description provided for @aboutSocialMediaLabel.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get aboutSocialMediaLabel;

  /// No description provided for @aboutSocialMediaValue.
  ///
  /// In en, this message translates to:
  /// **'Follow us on social platforms'**
  String get aboutSocialMediaValue;

  /// No description provided for @aboutMedicalInfo.
  ///
  /// In en, this message translates to:
  /// **'Medical Information'**
  String get aboutMedicalInfo;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 NutriGene. All rights reserved.'**
  String get aboutCopyright;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
