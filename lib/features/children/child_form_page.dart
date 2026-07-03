import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class ChildFormPage extends StatefulWidget {
  const ChildFormPage({super.key, this.child});
  final ChildProfile? child;

  @override
  State<ChildFormPage> createState() => _ChildFormPageState();
}

class _ChildFormPageState extends State<ChildFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _dobController;
  late final TextEditingController _guardianController;
  late final TextEditingController _contactController;
  late final TextEditingController _notesController;

  DateTime? _dob;
  String _selectedGender = 'Male';
  bool _isSaving = false;

  bool get _isEditing => widget.child != null;

  @override
  void initState() {
    super.initState();
    final c = widget.child;
    _nameController = TextEditingController(text: c?.name ?? '');
    _dobController = TextEditingController(
      text: c != null ? c.dob.toLocal().toString().split(' ').first : '',
    );
    _guardianController = TextEditingController(text: c?.guardianName ?? '');
    _contactController = TextEditingController(text: c?.contactNumber ?? '');
    _notesController = TextEditingController(text: c?.notes ?? '');
    _dob = c?.dob;
    _selectedGender = c?.gender ?? 'Male';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _guardianController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final provider = context.read<ChildrenProvider>();
    final profile = ChildProfile(
      id: widget.child?.id ?? '',
      userId: widget.child?.userId ?? '',
      name: _nameController.text.trim(),
      dob: _dob!,
      gender: _selectedGender,
      guardianName: _guardianController.text.trim(),
      contactNumber: _contactController.text.trim(),
      notes: _notesController.text.trim(),
    );

    try {
      if (_isEditing) {
        await provider.updateChild(profile);
      } else {
        await provider.addChild(profile);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(_isEditing ? 'Edit Profile' : 'Add Child'),
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
            _FormSection(
              title: 'Child Information',
              children: [
                _FieldLabel(label: 'Full name *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: "Enter child's full name",
                    prefixIcon: Icon(Icons.person_outline_rounded, size: 20),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 20),

                _FieldLabel(label: 'Date of birth *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Tap to select date',
                    prefixIcon: Icon(Icons.calendar_today_outlined, size: 20),
                  ),
                  validator: (_) =>
                      _dob == null ? 'Please select a date of birth' : null,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _dob ?? DateTime(2020),
                      firstDate: DateTime(2000),
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
                        _dob = picked;
                        _dobController.text =
                            picked.toLocal().toString().split(' ').first;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),

                _FieldLabel(label: 'Gender *'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedGender,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.wc_rounded, size: 20),
                  ),
                  items: ['Male', 'Female', 'Other']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedGender = v!),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _FormSection(
              title: 'Guardian Details',
              children: [
                _FieldLabel(label: 'Guardian name *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _guardianController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Parent or guardian name',
                    prefixIcon: Icon(Icons.family_restroom_rounded, size: 20),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Please enter a guardian name' : null,
                ),
                const SizedBox(height: 20),

                _FieldLabel(label: 'Contact number *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Phone number',
                    prefixIcon: Icon(Icons.phone_outlined, size: 20),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Please enter a contact number' : null,
                ),
              ],
            ),
            const SizedBox(height: 24),

            _FormSection(
              title: 'Additional Notes',
              children: [
                _FieldLabel(label: 'Notes (optional)'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Any medical history, allergies, or special notes...',
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(_isEditing ? 'Update Profile' : 'Save Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.title, required this.children});
  final String title;
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryColor,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppTheme.textPrimary,
      ),
    );
  }
}
