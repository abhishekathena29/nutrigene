import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class GrowthInputPage extends StatefulWidget {
  const GrowthInputPage({super.key});

  @override
  State<GrowthInputPage> createState() => _GrowthInputPageState();
}

class _GrowthInputPageState extends State<GrowthInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _muacController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _date = DateTime.now();
  String? _childId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _childId ??= ModalRoute.of(context)?.settings.arguments as String?;
    _dateController.text = _date.toLocal().toString().split(' ').first;
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _muacController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _saveRecord() async {
    if (!_formKey.currentState!.validate()) return;
    final record = GrowthRecord(
      id: '',
      date: _date,
      ageInMonths: double.tryParse(_ageController.text) ?? 0,
      weight: double.tryParse(_weightController.text) ?? 0,
      height: double.tryParse(_heightController.text) ?? 0,
      muac: double.tryParse(_muacController.text) ?? 0,
      notes: _notesController.text.trim(),
    );
    await context.read<ChildrenProvider>().addGrowthRecord(_childId!, record);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Growth data saved successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_childId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Growth Input')),
        body: const Center(
          child: Text('Please open this from a child profile.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Growth Input'),
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
          children: [
            // Info banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primarySurface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: AppTheme.primaryColor, size: 18),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Enter WHO standard growth measurements for accurate tracking.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.primaryColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Date section
            _FormSection(
              title: 'Measurement Date',
              icon: Icons.calendar_today_outlined,
              children: [
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Select date',
                    prefixIcon: Icon(Icons.event_rounded, size: 20),
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: AppTheme.primaryColor,
                              ),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) {
                      setState(() {
                        _date = picked;
                        _dateController.text =
                            picked.toLocal().toString().split(' ').first;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Measurements section
            _FormSection(
              title: 'Growth Measurements',
              icon: Icons.monitor_weight_outlined,
              children: [
                _MeasurementField(
                  controller: _ageController,
                  label: 'Age',
                  hint: 'e.g. 24',
                  suffix: 'months',
                  icon: Icons.child_care_rounded,
                  keyboardType: TextInputType.number,
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter age in months' : null,
                ),
                const SizedBox(height: 16),
                _MeasurementField(
                  controller: _weightController,
                  label: 'Weight',
                  hint: 'e.g. 12.5',
                  suffix: 'kg',
                  icon: Icons.monitor_weight_outlined,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter weight' : null,
                ),
                const SizedBox(height: 16),
                _MeasurementField(
                  controller: _heightController,
                  label: 'Height',
                  hint: 'e.g. 85',
                  suffix: 'cm',
                  icon: Icons.height_rounded,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter height' : null,
                ),
                const SizedBox(height: 16),
                _MeasurementField(
                  controller: _muacController,
                  label: 'MUAC',
                  hint: 'e.g. 14',
                  suffix: 'cm',
                  icon: Icons.straighten_rounded,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter MUAC' : null,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Notes section
            _FormSection(
              title: 'Observations',
              icon: Icons.notes_rounded,
              children: [
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Any additional observations or notes...',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveRecord,
                child: const Text('Save Measurements'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _MeasurementField extends StatelessWidget {
  const _MeasurementField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.suffix,
    required this.icon,
    required this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String suffix;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 18),
            suffix: Text(
              suffix,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
