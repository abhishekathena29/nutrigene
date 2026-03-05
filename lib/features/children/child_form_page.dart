import 'package:flutter/material.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class ChildFormPage extends StatefulWidget {
  /// Pass [child] to pre-fill the form for editing. Leave null to add new.
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
    } catch (e) {
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
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Child Profile' : 'Add Child Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Child Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: "Enter child's name",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter a name'
                    : null,
              ),
              const SizedBox(height: 16),

              // Date of birth
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth *',
                  hintText: 'Tap to select',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                validator: (_) => _dob == null ? 'Select date of birth' : null,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _dob ?? DateTime(2020),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _dob = picked;
                      _dobController.text = picked
                          .toLocal()
                          .toString()
                          .split(' ')
                          .first;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Gender
              DropdownButtonFormField<String>(
                initialValue: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender *',
                  prefixIcon: Icon(Icons.wc),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedGender = v!),
              ),
              const SizedBox(height: 16),

              // Guardian
              TextFormField(
                controller: _guardianController,
                decoration: const InputDecoration(
                  labelText: 'Parent / Guardian Name *',
                  hintText: 'Enter parent name',
                  prefixIcon: Icon(Icons.family_restroom),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter guardian name'
                    : null,
              ),
              const SizedBox(height: 16),

              // Contact
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number *',
                  hintText: 'Enter phone number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Please enter a contact number'
                    : null,
              ),
              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Additional information',
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Save button — uses local _isSaving, NOT provider.isLoading
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          _isEditing ? 'Update Profile' : 'Save Profile',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
