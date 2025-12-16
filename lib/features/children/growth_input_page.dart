import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Growth Input')),
      body: _childId == null
          ? const Center(
              child: Text('Please open this from a child profile.'),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.blue),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Enter growth measurements for tracking',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Measurement Date',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dateController
                        ..text =
                            _date.toLocal().toString().split(' ').first,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        hintText: 'DD/MM/YYYY',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
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
                    const SizedBox(height: 24),
                    const Text(
                      'Growth Measurements',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age (months)',
                        hintText: 'Enter age in months',
                        prefixIcon: Icon(Icons.child_care),
                        suffixText: 'months',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight',
                        hintText: 'Enter weight',
                        prefixIcon: Icon(Icons.monitor_weight),
                        suffixText: 'kg',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter weight' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height',
                        hintText: 'Enter height',
                        prefixIcon: Icon(Icons.height),
                        suffixText: 'cm',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter height' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _muacController,
                      decoration: const InputDecoration(
                        labelText: 'MUAC (Mid-Upper Arm Circumference)',
                        hintText: 'Enter MUAC',
                        prefixIcon: Icon(Icons.straighten),
                        suffixText: 'cm',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter MUAC' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        hintText: 'Any additional observations',
                        prefixIcon: Icon(Icons.notes),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final record = GrowthRecord(
                            id: '',
                            date: _date,
                            ageInMonths:
                                double.tryParse(_ageController.text) ?? 0,
                            weight:
                                double.tryParse(_weightController.text) ?? 0,
                            height:
                                double.tryParse(_heightController.text) ?? 0,
                            muac: double.tryParse(_muacController.text) ?? 0,
                            notes: _notesController.text.trim(),
                          );
                          await context
                              .read<ChildrenProvider>()
                              .addGrowthRecord(_childId!, record);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Growth data saved successfully!'),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Save Measurements',
                          style: TextStyle(fontSize: 16),
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
