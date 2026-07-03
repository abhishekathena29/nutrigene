import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/nutrition/provider/nutrition_provider.dart';
import 'package:provider/provider.dart';

class SymptomsCheckerPage extends StatefulWidget {
  const SymptomsCheckerPage({super.key});

  @override
  State<SymptomsCheckerPage> createState() => _SymptomsCheckerPageState();
}

class _SymptomsCheckerPageState extends State<SymptomsCheckerPage> {
  final Set<String> _selectedSymptoms = {};

  static const Map<String, IconData> _symptoms = {
    'Fatigue or weakness': Icons.bedtime_rounded,
    'Pale skin': Icons.face_rounded,
    'Hair loss': Icons.self_improvement_rounded,
    'Brittle nails': Icons.pan_tool_rounded,
    'Poor appetite': Icons.no_meals_rounded,
    'Delayed growth': Icons.child_care_rounded,
    'Frequent infections': Icons.sick_rounded,
    'Poor concentration': Icons.psychology_rounded,
    'Muscle weakness': Icons.fitness_center_rounded,
    'Night blindness': Icons.dark_mode_rounded,
    'Skin problems': Icons.healing_rounded,
    'Slow wound healing': Icons.medical_services_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NutritionProvider>();
    final hasResults = provider.symptomAnalysis != null &&
        provider.symptomAnalysis!.isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Symptoms Checker'),
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
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Disclaimer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: AppTheme.warningColor, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This provides general guidance only — not a medical diagnosis. Consult a healthcare professional for concerns.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.warningColor,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Symptoms',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              if (_selectedSymptoms.isNotEmpty)
                Text(
                  '${_selectedSymptoms.length} selected',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Symptoms grid
          ..._symptoms.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _SymptomTile(
                symptom: entry.key,
                icon: entry.value,
                isSelected: _selectedSymptoms.contains(entry.key),
                onToggle: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedSymptoms.add(entry.key);
                    } else {
                      _selectedSymptoms.remove(entry.key);
                    }
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedSymptoms.isEmpty || provider.aiBusy
                  ? null
                  : () => provider.analyzeSymptoms(_selectedSymptoms.toList()),
              child: provider.aiBusy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      _selectedSymptoms.isEmpty
                          ? 'Select symptoms to check'
                          : 'Check Deficiencies (${_selectedSymptoms.length})',
                    ),
            ),
          ),

          if (provider.aiError != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                provider.aiError!,
                style: const TextStyle(fontSize: 13, color: AppTheme.errorColor),
              ),
            ),
          ],

          if (hasResults) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: AppTheme.primaryColor, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Assessment Results',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    provider.symptomAnalysis!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textPrimary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SymptomTile extends StatelessWidget {
  const _SymptomTile({
    required this.symptom,
    required this.icon,
    required this.isSelected,
    required this.onToggle,
  });

  final String symptom;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!isSelected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primarySurface : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryColor.withValues(alpha: 0.15)
                    : AppTheme.inputFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: isSelected ? AppTheme.primaryColor : AppTheme.textTertiary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                symptom,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
