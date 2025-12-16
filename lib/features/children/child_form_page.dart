import 'package:flutter/material.dart';
import 'package:nutritrack/features/children/provider/children_provider.dart';
import 'package:provider/provider.dart';

class ChildFormPage extends StatefulWidget {
  const ChildFormPage({super.key});

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
  ChildProfile? _editingChild;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _guardianController = TextEditingController();
    _contactController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ChildProfile && _editingChild == null) {
      _editingChild = args;
      _nameController.text = args.name;
      _dob = args.dob;
      _dobController.text = args.dob.toLocal().toString().split(' ').first;
      _selectedGender = args.gender;
      _guardianController.text = args.guardianName;
      _contactController.text = args.contactNumber;
      _notesController.text = args.notes;
    }
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

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingChild != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Child Profile' : 'Add Child Profile'),
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter child\'s name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  hintText: 'DD/MM/YYYY',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                validator: (_) => _dob == null ? 'Select date of birth' : null,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _dob ?? DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime.now(),
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
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.wc),
                ),
                items: ['Male', 'Female', 'Other']
                    .map(
                      (gender) =>
                          DropdownMenuItem(value: gender, child: Text(gender)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _guardianController,
                decoration: const InputDecoration(
                  labelText: 'Parent/Guardian Name',
                  hintText: 'Enter parent name',
                  prefixIcon: Icon(Icons.family_restroom),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  hintText: 'Enter phone number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final child = ChildProfile(
                      id: _editingChild?.id ?? '',
                      name: _nameController.text.trim(),
                      dob: _dob ?? DateTime.now(),
                      gender: _selectedGender,
                      guardianName: _guardianController.text.trim(),
                      contactNumber: _contactController.text.trim(),
                      notes: _notesController.text.trim(),
                    );
                    await context.read<ChildrenProvider>().addOrUpdateChild(
                          child,
                        );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isEditing
                                ? 'Profile updated'
                                : 'Child profile saved',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Save Profile', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
