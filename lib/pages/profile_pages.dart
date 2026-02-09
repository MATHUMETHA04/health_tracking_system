import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/user.dart';
import '../widgets/auth_button.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _languageController = TextEditingController();
  final _bloodPressureController = TextEditingController();
  final _diabetesController = TextEditingController();
  final _diseasesController = TextEditingController();
  final _allergiesController = TextEditingController();
  String? _qrData;

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final profile = {
        'name': _nameController.text,
        'blood_group': _bloodGroupController.text,
        'phone': _phoneController.text,
        'emergency_contact': _emergencyContactController.text,
        'relationship': _relationshipController.text,
        'height': _heightController.text,
        'weight': _weightController.text,
        'language': _languageController.text,
        'blood_pressure': _bloodPressureController.text,
        'diabetes': _diabetesController.text,
        'diseases': _diseasesController.text,
        'allergies': _allergiesController.text,
      };
      patientProfiles[widget.username] = profile;
      setState(() {
        _qrData = profile.entries.map((e) => '${e.key}: ${e.value}').join('\n');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration('Name'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _bloodGroupController,
                      decoration: _inputDecoration('Blood Group'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: _inputDecoration('Phone Number'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emergencyContactController,
                      decoration: _inputDecoration('Emergency Contact Number'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _relationshipController,
                      decoration: _inputDecoration('Relationship to Emergency Contact'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _heightController,
                      decoration: _inputDecoration('Height (cm)'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _weightController,
                      decoration: _inputDecoration('Weight (kg)'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _languageController,
                      decoration: _inputDecoration('Regional Language'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _bloodPressureController,
                      decoration: _inputDecoration('Blood Pressure'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _diabetesController,
                      decoration: _inputDecoration('Diabetes (Type 1/Type 2/None)'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _diseasesController,
                      decoration: _inputDecoration('Other Diseases'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _allergiesController,
                      decoration: _inputDecoration('Allergies'),
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      text: 'Save Profile',
                      color: Colors.green.shade700,
                      onPressed: _saveProfile,
                    ),
                    if (_qrData != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Profile QR Code',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 10),
                      QrImageView(
                        data: _qrData!,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
  }
}