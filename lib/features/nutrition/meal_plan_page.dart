import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/core/widgets/sources_link.dart';
import 'package:nutritrack/features/nutrition/provider/nutrition_provider.dart';
import 'package:nutritrack/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MealPlanPage extends StatefulWidget {
  const MealPlanPage({super.key});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  String _selectedDay = 'Monday';
  bool _didLoad = false;

  static const _days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday',
  ];

  static const _mealTimes = [
    ('Breakfast', '7:00 AM', Icons.wb_sunny_rounded, Color(0xFFF97316)),
    ('Mid-Morning', '10:00 AM', Icons.coffee_rounded, Color(0xFF92400E)),
    ('Lunch', '12:30 PM', Icons.lunch_dining_rounded, AppTheme.primaryColor),
    ('Afternoon', '3:30 PM', Icons.icecream_rounded, Color(0xFFEC4899)),
    ('Dinner', '7:00 PM', Icons.dinner_dining_rounded, AppTheme.secondaryColor),
  ];

  static String _dayLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'Monday':
        return l10n.dayMonday;
      case 'Tuesday':
        return l10n.dayTuesday;
      case 'Wednesday':
        return l10n.dayWednesday;
      case 'Thursday':
        return l10n.dayThursday;
      case 'Friday':
        return l10n.dayFriday;
      case 'Saturday':
        return l10n.daySaturday;
      case 'Sunday':
        return l10n.daySunday;
      default:
        return key;
    }
  }

  static String _mealLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'Breakfast':
        return l10n.mealBreakfast;
      case 'Mid-Morning':
        return l10n.mealMidMorning;
      case 'Lunch':
        return l10n.mealLunch;
      case 'Afternoon':
        return l10n.mealAfternoon;
      case 'Dinner':
        return l10n.mealDinner;
      default:
        return key;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_didLoad && mounted) {
        context.read<NutritionProvider>().loadMealPlans();
        _didLoad = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.watch<NutritionProvider>();
    final mealPlan = provider.mealPlans[_selectedDay];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(l10n.mealPlanTitle),
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
        actions: [
          if (mealPlan != null)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppTheme.errorColor,
              onPressed: () => _confirmDeletePlan(context),
              tooltip: l10n.mealPlanDeletePlanTooltip,
            ),
          IconButton(
            icon: provider.loadingPlans
                ? const SizedBox(
                    width: 18, height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh_rounded),
            onPressed: provider.loadingPlans ? null : provider.loadMealPlans,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: provider.aiBusy ? null : () => _promptForGeneration(context),
        icon: provider.aiBusy
            ? const SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Icon(Icons.auto_awesome_rounded),
        label: Text(l10n.mealPlanAiGenerate),
      ),
      body: Column(
        children: [
          // Day selector
          Container(
            color: AppTheme.backgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _days.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final day = _days[i];
                  final isSelected = day == _selectedDay;
                  final hasData = provider.mealPlans[day] != null;
                  final dayLabel = _dayLabel(l10n, day);
                  return GestureDetector(
                    onTap: () => setState(() => _selectedDay = day),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Localizations.localeOf(context).languageCode == 'en'
                                ? dayLabel.substring(0, 3)
                                : dayLabel,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : AppTheme.textPrimary,
                            ),
                          ),
                          if (hasData) ...[
                            const SizedBox(width: 5),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.7)
                                    : AppTheme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Error banner
          if (provider.aiError != null)
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppTheme.errorColor, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      provider.aiError!,
                      style: const TextStyle(fontSize: 13, color: AppTheme.errorColor),
                    ),
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              children: [
                const SourcesLink(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dayLabel(l10n, _selectedDay),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                if (mealPlan != null && mealPlan.meals.isNotEmpty) ...[
                  ..._mealTimes.map((m) {
                    final (label, time, icon, color) = m;
                    final desc = mealPlan.meals[label] ?? '';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _MealCard(
                        mealType: _mealLabel(l10n, label),
                        time: time,
                        icon: icon,
                        color: color,
                        description: desc,
                        notSetLabel: l10n.mealPlanNotSet,
                        onEdit: () => _editMeal(label, desc),
                      ),
                    );
                  }),
                  if (mealPlan.aiNote != null && mealPlan.aiNote!.trim().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lightbulb_outline_rounded,
                              color: AppTheme.secondaryColor, size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              mealPlan.aiNote!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.secondaryColor,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.restaurant_menu_rounded, size: 48, color: AppTheme.textTertiary),
                        const SizedBox(height: 16),
                        Text(
                          l10n.mealPlanNoPlanTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.mealPlanNoPlanSubtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: provider.aiBusy
                              ? null
                              : () => _promptForGeneration(context),
                          icon: const Icon(Icons.auto_awesome_rounded, size: 18),
                          label: Text(l10n.mealPlanGenerateWithAi),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: provider.aiBusy
                              ? null
                              : () => _promptForManualPlan(context),
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: Text(l10n.mealPlanCreateManually),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _promptForGeneration(BuildContext ctx) async {
    final l10n = AppLocalizations.of(ctx)!;
    final preferencesController = TextEditingController();
    final ageController = TextEditingController(text: '5 years');
    final provider = ctx.read<NutritionProvider>();
    final shouldGenerate = await showDialog<bool>(
      context: ctx,
      builder: (dlgCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.mealPlanGenerateWithAi),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: l10n.mealPlanChildAgeLabel,
                hintText: l10n.mealPlanChildAgeHint,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: preferencesController,
              decoration: InputDecoration(
                labelText: l10n.mealPlanPreferencesLabel,
                hintText: l10n.mealPlanPreferencesHint,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dlgCtx, false), child: Text(l10n.commonCancel)),
          ElevatedButton(onPressed: () => Navigator.pop(dlgCtx, true), child: Text(l10n.mealPlanGenerateAction)),
        ],
      ),
    );
    if (shouldGenerate == true) {
      await provider.generatePlan(
        day: _selectedDay,
        childAge: ageController.text,
        preferences: preferencesController.text.isEmpty ? null : preferencesController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.mealPlanSavedMessage)));
    }
  }

  Future<void> _promptForManualPlan(BuildContext ctx) async {
    final l10n = AppLocalizations.of(ctx)!;
    final controllers = {
      'Breakfast': TextEditingController(),
      'Mid-Morning': TextEditingController(),
      'Lunch': TextEditingController(),
      'Afternoon': TextEditingController(),
      'Dinner': TextEditingController(),
    };
    final noteController = TextEditingController();
    final provider = ctx.read<NutritionProvider>();

    final shouldSave = await showDialog<bool>(
      context: ctx,
      builder: (dlgCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.mealPlanCreateForDay(_dayLabel(l10n, _selectedDay))),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...controllers.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: e.value,
                    decoration: InputDecoration(labelText: _mealLabel(l10n, e.key)),
                  ),
                ),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: l10n.mealPlanNoteLabel),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dlgCtx, false), child: Text(l10n.commonCancel)),
          ElevatedButton(onPressed: () => Navigator.pop(dlgCtx, true), child: Text(l10n.commonSave)),
        ],
      ),
    );
    if (shouldSave == true) {
      await provider.saveMealPlan(MealPlan(
        day: _selectedDay,
        meals: {for (final e in controllers.entries) e.key: e.value.text.trim()},
        aiNote: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
      ));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.mealPlanSavedMessage)));
    }
  }

  Future<void> _editMeal(String mealType, String existing) async {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.read<NutritionProvider>();
    final controller = TextEditingController(text: existing);
    final mealTypeLabel = _mealLabel(l10n, mealType);
    final shouldSave = await showDialog<bool>(
      context: context,
      builder: (dlgCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.mealPlanEditTitle(mealTypeLabel)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: l10n.mealPlanDescriptionLabel),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dlgCtx, false), child: Text(l10n.commonCancel)),
          ElevatedButton(onPressed: () => Navigator.pop(dlgCtx, true), child: Text(l10n.commonSave)),
        ],
      ),
    );
    if (shouldSave == true) {
      final current = provider.mealPlans[_selectedDay];
      final updatedMeals = Map<String, String>.from(
        current?.meals ?? {'Breakfast': '', 'Mid-Morning': '', 'Lunch': '', 'Afternoon': '', 'Dinner': ''},
      );
      updatedMeals[mealType] = controller.text.trim();
      await provider.saveMealPlan(
        MealPlan(day: _selectedDay, meals: updatedMeals, aiNote: current?.aiNote),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.mealPlanUpdatedMessage(mealTypeLabel))));
    }
  }

  Future<void> _confirmDeletePlan(BuildContext ctx) async {
    final l10n = AppLocalizations.of(ctx)!;
    final provider = ctx.read<NutritionProvider>();
    final confirm = await showDialog<bool>(
      context: ctx,
      builder: (dlgCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.mealPlanDeleteConfirmTitle),
        content: Text(l10n.mealPlanDeleteConfirmBody(_dayLabel(l10n, _selectedDay))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dlgCtx, false), child: Text(l10n.commonCancel)),
          ElevatedButton(
            onPressed: () => Navigator.pop(dlgCtx, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await provider.deleteMealPlan(_selectedDay);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.mealPlanDeletedMessage)));
    }
  }
}

class _MealCard extends StatelessWidget {
  const _MealCard({
    required this.mealType,
    required this.time,
    required this.icon,
    required this.color,
    required this.description,
    required this.notSetLabel,
    required this.onEdit,
  });

  final String mealType;
  final String time;
  final IconData icon;
  final Color color;
  final String description;
  final String notSetLabel;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final hasDesc = description.isNotEmpty;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      mealType,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textTertiary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  hasDesc ? description : notSetLabel,
                  style: TextStyle(
                    fontSize: 13,
                    color: hasDesc ? AppTheme.textSecondary : AppTheme.textTertiary,
                    fontStyle: hasDesc ? FontStyle.normal : FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.inputFill,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.edit_rounded, size: 15, color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
