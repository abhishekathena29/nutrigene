// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get navDashboard => 'डैशबोर्ड';

  @override
  String get navChildren => 'बच्चे';

  @override
  String get navNutrition => 'पोषण';

  @override
  String get navBrain => 'मस्तिष्क';

  @override
  String get navMore => 'अधिक';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonDelete => 'हटाएं';

  @override
  String get commonSave => 'सहेजें';

  @override
  String get commonRetry => 'पुनः प्रयास करें';

  @override
  String get commonAdd => 'जोड़ें';

  @override
  String get dashboardGreeting => 'सुप्रभात,\nन्यूट्रीगार्जियन';

  @override
  String get dashboardTagline =>
      'AI-चयनित जानकारियां तैयार हैं। अपने बच्चों को स्वस्थ रखें।';

  @override
  String get dashboardWellnessLogged => 'स्वास्थ्य दर्ज';

  @override
  String get dashboardMealsPlanned => 'भोजन योजनाएं';

  @override
  String get dashboardViewTodaysFocus => 'आज का फोकस देखें';

  @override
  String get dashboardTodaysSnapshot => 'आज का सारांश';

  @override
  String get dashboardViewAll => 'सभी देखें';

  @override
  String get dashboardMealsLabel => 'भोजन';

  @override
  String get dashboardActivitiesLabel => 'गतिविधियां';

  @override
  String get dashboardTodaysMeals => 'आज के भोजन';

  @override
  String get dashboardNoMealsPlanned => 'आज के लिए कोई भोजन योजना नहीं';

  @override
  String get dashboardKeyAlerts => 'मुख्य अलर्ट';

  @override
  String get dashboardAllCaughtUp => 'सब कुछ अपडेट है — कोई अलर्ट नहीं।';

  @override
  String get dashboardQuickActions => 'त्वरित कार्य';

  @override
  String get dashboardMealPlansAction => 'भोजन योजनाएं';

  @override
  String get dashboardBrainTipsAction => 'मस्तिष्क सुझाव';

  @override
  String get dashboardGrowthAction => 'विकास';

  @override
  String get childrenAddedMessage => 'बाल प्रोफ़ाइल जोड़ी गई।';

  @override
  String get childrenUpdatedMessage => 'बाल प्रोफ़ाइल अपडेट की गई।';

  @override
  String childrenProfileCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रोफ़ाइल',
    );
    return '$_temp0';
  }

  @override
  String get childrenNoneYetTitle => 'अभी कोई बच्चा नहीं';

  @override
  String get childrenNoneYetSubtitle =>
      'उनकी वृद्धि और पोषण को ट्रैक करने के लिए\nएक बाल प्रोफ़ाइल जोड़ें।';

  @override
  String get childrenAddFirst => 'पहला बच्चा जोड़ें';

  @override
  String get childrenDeleteTitle => 'प्रोफ़ाइल हटाएं?';

  @override
  String childrenDeleteConfirm(Object name) {
    return '$name की प्रोफ़ाइल स्थायी रूप से हटाएं? इसे पूर्ववत नहीं किया जा सकता।';
  }

  @override
  String childrenDeletedMessage(Object name) {
    return '$name हटा दिया गया।';
  }

  @override
  String get childrenDeleteFailed => 'हटाने में विफल। पुनः प्रयास करें।';

  @override
  String childrenGuardianLabel(Object name) {
    return 'अभिभावक: $name';
  }

  @override
  String get nutritionHubTitle => 'पोषण केंद्र';

  @override
  String get nutritionHubSubtitle =>
      'भोजन योजनाएं, रेसिपी और पोषण संबंधी जानकारी।';

  @override
  String get nutritionExploreLabel => 'अन्वेषण करें';

  @override
  String get nutritionFoodAccessTitle => 'भोजन की उपलब्धता और किफ़ायत';

  @override
  String get nutritionFoodAccessDesc => 'किफ़ायती दामों में पोषक विकल्प';

  @override
  String get nutritionMealPlansDesc => 'AI-संचालित साप्ताहिक भोजन सुझाव';

  @override
  String get nutritionRecipesTitle => 'रेसिपी';

  @override
  String get nutritionRecipesDesc => 'बच्चों के लिए बनाई गई पोषक रेसिपी';

  @override
  String get nutritionSymptomsTitle => 'लक्षण जांचकर्ता';

  @override
  String get nutritionSymptomsDesc => 'पोषण की कमी की जांच करें';

  @override
  String get mealPlanTitle => 'भोजन योजनाएं';

  @override
  String get mealPlanDeletePlanTooltip => 'योजना हटाएं';

  @override
  String get mealPlanAiGenerate => 'AI से बनाएं';

  @override
  String get mealPlanNoPlanTitle => 'इस दिन के लिए कोई भोजन योजना नहीं';

  @override
  String get mealPlanNoPlanSubtitle =>
      'AI-संचालित योजना बनाएं या इसे स्वयं तैयार करें।';

  @override
  String get mealPlanGenerateWithAi => 'AI से बनाएं';

  @override
  String get mealPlanCreateManually => 'स्वयं बनाएं';

  @override
  String get mealPlanNotSet => 'सेट नहीं — जोड़ने के लिए टैप करें';

  @override
  String get mealPlanChildAgeLabel => 'बच्चे की उम्र';

  @override
  String get mealPlanChildAgeHint => 'उदा. 5 वर्ष';

  @override
  String get mealPlanPreferencesLabel => 'पसंद या प्रतिबंध';

  @override
  String get mealPlanPreferencesHint => 'उदा. शाकाहारी, बिना मेवे';

  @override
  String get mealPlanGenerateAction => 'बनाएं';

  @override
  String get mealPlanSavedMessage => 'भोजन योजना सहेजी गई';

  @override
  String mealPlanCreateForDay(Object day) {
    return '$day के लिए योजना बनाएं';
  }

  @override
  String get mealPlanNoteLabel => 'टिप्पणी (वैकल्पिक)';

  @override
  String mealPlanEditTitle(Object mealType) {
    return '$mealType संपादित करें';
  }

  @override
  String get mealPlanDescriptionLabel => 'भोजन का विवरण';

  @override
  String mealPlanUpdatedMessage(Object mealType) {
    return '$mealType अपडेट किया गया';
  }

  @override
  String get mealPlanDeleteConfirmTitle => 'भोजन योजना हटाएं?';

  @override
  String mealPlanDeleteConfirmBody(Object day) {
    return '$day की भोजन योजना हटाएं?';
  }

  @override
  String get mealPlanDeletedMessage => 'भोजन योजना हटाई गई';

  @override
  String get mealBreakfast => 'नाश्ता';

  @override
  String get mealMidMorning => 'मध्य-सुबह';

  @override
  String get mealLunch => 'दोपहर का भोजन';

  @override
  String get mealAfternoon => 'दोपहर बाद';

  @override
  String get mealDinner => 'रात का भोजन';

  @override
  String get dayMonday => 'सोमवार';

  @override
  String get dayTuesday => 'मंगलवार';

  @override
  String get dayWednesday => 'बुधवार';

  @override
  String get dayThursday => 'गुरुवार';

  @override
  String get dayFriday => 'शुक्रवार';

  @override
  String get daySaturday => 'शनिवार';

  @override
  String get daySunday => 'रविवार';

  @override
  String get moreTitle => 'प्रोफ़ाइल';

  @override
  String get moreVerified => 'सत्यापित';

  @override
  String get moreNotVerified => 'असत्यापित';

  @override
  String get moreNameLabel => 'नाम';

  @override
  String get moreEmailLabel => 'ईमेल';

  @override
  String get moreNgoDashboard => 'NGO डैशबोर्ड';

  @override
  String get moreSettings => 'सेटिंग्स';

  @override
  String get moreAboutNutriGene => 'NutriGene के बारे में';

  @override
  String get moreSourcesReferences => 'स्रोत और संदर्भ';

  @override
  String get moreSignOutTitle => 'साइन आउट करें?';

  @override
  String get moreSignOutBody => 'आपको लॉगिन स्क्रीन पर वापस भेज दिया जाएगा।';

  @override
  String get moreSignOutAction => 'साइन आउट करें';

  @override
  String get moreDeleteAccountTitle => 'खाता हटाएं?';

  @override
  String get moreDeleteAccountBody =>
      'इससे आपका खाता स्थायी रूप से हटा दिया जाएगा और इसे पूर्ववत नहीं किया जा सकता। सभी संबंधित डेटा नष्ट हो जाएगा।';

  @override
  String get moreDeleteAccountAction => 'खाता हटाएं';

  @override
  String get settingsGeneralSection => 'सामान्य';

  @override
  String get settingsNotifications => 'सूचनाएं';

  @override
  String get settingsNotificationsDesc => 'अलर्ट और रिमाइंडर प्राप्त करें';

  @override
  String get settingsDarkMode => 'डार्क मोड';

  @override
  String get settingsDarkModeDesc => 'डार्क थीम का उपयोग करें';

  @override
  String get settingsLanguageSection => 'भाषा और क्षेत्र';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsSelectLanguage => 'भाषा चुनें';

  @override
  String get settingsDataPrivacySection => 'डेटा और निजता';

  @override
  String get settingsBackupData => 'डेटा का बैकअप लें';

  @override
  String get settingsBackupDataValue => 'क्लाउड में सहेजें';

  @override
  String get settingsBackingUp => 'डेटा का बैकअप लिया जा रहा है...';

  @override
  String get settingsExportData => 'डेटा निर्यात करें';

  @override
  String get settingsExportDataValue => 'अपना डेटा डाउनलोड करें';

  @override
  String get settingsExporting => 'डेटा निर्यात किया जा रहा है...';

  @override
  String get settingsClearAllData => 'सभी डेटा हटाएं';

  @override
  String get settingsClearAllDataValue => 'स्थायी रूप से हटाएं';

  @override
  String get settingsClearDataTitle => 'सभी डेटा हटाएं?';

  @override
  String get settingsClearDataBody =>
      'इससे सभी डेटा स्थायी रूप से हटा दिया जाएगा। यह कार्रवाई पूर्ववत नहीं की जा सकती।';

  @override
  String get settingsDataCleared => 'डेटा सफलतापूर्वक हटाया गया';

  @override
  String get settingsClearAction => 'साफ़ करें';

  @override
  String get settingsSupportSection => 'सहायता';

  @override
  String get settingsHelpCenter => 'सहायता केंद्र';

  @override
  String get settingsOpeningHelp => 'सहायता केंद्र खोला जा रहा है...';

  @override
  String get settingsSendFeedback => 'प्रतिक्रिया भेजें';

  @override
  String get settingsOpeningFeedback => 'प्रतिक्रिया फ़ॉर्म खोला जा रहा है...';

  @override
  String get settingsReportBug => 'बग की रिपोर्ट करें';

  @override
  String get settingsOpeningBugReport => 'बग रिपोर्ट खोली जा रही है...';

  @override
  String get loginPleaseEnterCreds => 'कृपया अपना ईमेल और पासवर्ड दर्ज करें।';

  @override
  String get loginEnterEmailToReset =>
      'अपना पासवर्ड रीसेट करने के लिए अपना ईमेल दर्ज करें।';

  @override
  String loginResetLinkSent(Object email) {
    return '$email पर पासवर्ड रीसेट लिंक भेजा गया।';
  }

  @override
  String get loginWelcomeBack => 'वापसी पर\nस्वागत है';

  @override
  String get loginSubtitle =>
      'स्वस्थ विकास को ट्रैक और समर्थन करना जारी रखने के लिए साइन इन करें।';

  @override
  String get loginEmailLabel => 'ईमेल पता';

  @override
  String get loginPasswordLabel => 'पासवर्ड';

  @override
  String get loginForgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get loginSignInAction => 'साइन इन करें';

  @override
  String get loginOrDivider => 'या';

  @override
  String get loginContinueWithGoogle => 'Google से जारी रखें';

  @override
  String get loginNoAccount => 'खाता नहीं है?';

  @override
  String get loginSignUpLink => 'साइन अप करें';

  @override
  String get signupPleaseComplete => 'कृपया सभी आवश्यक फ़ील्ड भरें।';

  @override
  String get signupPasswordsMismatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get signupCreateAccountHeader => 'अपना\nखाता बनाएं';

  @override
  String get signupSubtitle =>
      'NutriGene से जुड़ें और आज ही बच्चों के स्वास्थ्य में सहयोग करना शुरू करें।';

  @override
  String get signupFullNameLabel => 'पूरा नाम';

  @override
  String get signupFirstNameHint => 'पहला नाम';

  @override
  String get signupLastNameHint => 'अंतिम नाम';

  @override
  String get signupPasswordHint => 'न्यूनतम 8 अक्षर';

  @override
  String get signupConfirmPasswordLabel => 'पासवर्ड की पुष्टि करें';

  @override
  String get signupConfirmPasswordHint => 'अपना पासवर्ड फिर से दर्ज करें';

  @override
  String get signupCreateAccountAction => 'खाता बनाएं';

  @override
  String get signupTerms =>
      'खाता बनाकर, आप हमारी सेवा की शर्तों और निजता नीति से सहमत होते हैं।';

  @override
  String get signupAlreadyHaveAccount => 'पहले से खाता है?';

  @override
  String get aboutVersion => 'संस्करण 1.0.0';

  @override
  String get aboutOurMission => 'हमारा उद्देश्य';

  @override
  String get aboutMissionBody =>
      'NutriGene एक AI-संचालित पोषण ट्रैकर और सहायक है जो व्यक्तिगत पोषण सिफारिशों, विकास मॉनिटरिंग और शीघ्र हस्तक्षेप के माध्यम से बाल कुपोषण से लड़ने के लिए डिज़ाइन किया गया है।';

  @override
  String get aboutKeyFeatures => 'मुख्य विशेषताएं';

  @override
  String get aboutFeatureGrowthTitle => 'विकास ट्रैकिंग';

  @override
  String get aboutFeatureGrowthDesc =>
      'WHO मानकों का उपयोग करके बच्चों की वृद्धि की निगरानी करें';

  @override
  String get aboutFeatureAiTitle => 'AI सिफारिशें';

  @override
  String get aboutFeatureAiDesc => 'AI द्वारा संचालित व्यक्तिगत पोषण सलाह';

  @override
  String get aboutFeatureEpigeneticTitle => 'एपिजेनेटिक जोखिम आकलन';

  @override
  String get aboutFeatureEpigeneticDesc => 'पोषण की कमी का शीघ्र पता लगाना';

  @override
  String get aboutFeatureBrainTitle => 'मस्तिष्क विकास';

  @override
  String get aboutFeatureBrainDesc =>
      'संज्ञानात्मक विकास के लिए गतिविधियां और पोषण सुझाव';

  @override
  String get aboutFeatureNgoTitle => 'NGO सहायता';

  @override
  String get aboutFeatureNgoDesc =>
      'कई बच्चों का प्रबंधन करने वाले संगठनों के लिए उपकरण';

  @override
  String get aboutImpactTitle =>
      'साथ मिलकर, हम बाल कुपोषण को समाप्त कर सकते हैं';

  @override
  String get aboutImpactBody =>
      'NutriGene, NGO, देखभालकर्ताओं और स्वास्थ्य कार्यकर्ताओं की मदद के लिए अपनी पहुंच बढ़ा रहा है ताकि वे दुनिया भर में बच्चों के विकास की निगरानी करें, कुपोषण से लड़ें, और कार्रवाई योग्य AI जानकारियां प्रदान करें।';

  @override
  String get aboutGetInTouch => 'संपर्क करें';

  @override
  String get aboutWebsiteLabel => 'वेबसाइट';

  @override
  String get aboutSocialMediaLabel => 'सोशल मीडिया';

  @override
  String get aboutSocialMediaValue => 'हमें सोशल प्लेटफ़ॉर्म पर फॉलो करें';

  @override
  String get aboutMedicalInfo => 'मेडिकल जानकारी';

  @override
  String get aboutCopyright => '© 2025 NutriGene. सर्वाधिकार सुरक्षित।';
}
