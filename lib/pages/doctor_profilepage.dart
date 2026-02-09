import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/auth_button.dart';

class DoctorProfilePage extends StatefulWidget {
  final String username;

  const DoctorProfilePage({super.key, required this.username});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _experienceController = TextEditingController();
  final _specializationController = TextEditingController();
  final _certificateController = TextEditingController();

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final profile = {
        'name': _nameController.text,
        'age': _ageController.text,
        'phone': _phoneController.text,
        'hospital': _hospitalController.text,
        'experience': _experienceController.text,
        'specialization': _specializationController.text,
        'certificate': _certificateController.text,
      };
      doctorProfiles[widget.username] = profile;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Profile'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
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
                      controller: _ageController,
                      decoration: _inputDecoration('Age'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneController,
                      decoration: _inputDecoration('Phone Number'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _hospitalController,
                      decoration: _inputDecoration('Hospital Name'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _experienceController,
                      decoration: _inputDecoration('Years of Experience'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _specializationController,
                      decoration: _inputDecoration('Specialization'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _certificateController,
                      decoration: _inputDecoration('Degree Certificate (File Path)'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      text: 'Save Profile',
                      color: Colors.blue.shade700,
                      onPressed: _saveProfile,
                    ),
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