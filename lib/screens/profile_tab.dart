import 'package:flutter/material.dart';
import '../models/user.dart' as models;

class ProfileTab extends StatefulWidget {
  final models.MutableUser userProfile;

  const ProfileTab({required this.userProfile});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late String _selectedGender;
  late DateTime _selectedDate;
  bool _isFemaleAbove18 = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _phoneController = TextEditingController(text: widget.userProfile.phone);
    _selectedGender = widget.userProfile.gender;
    _selectedDate = widget.userProfile.dateOfBirth;
    _checkWomenHealthEligibility();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _checkWomenHealthEligibility() {
    final age = DateTime.now().difference(_selectedDate).inDays ~/ 365;
    setState(() {
      _isFemaleAbove18 = _selectedGender.toLowerCase() == 'female' && age > 18;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
            ),
            items:
                ['male', 'female', 'others']
                    .map(
                      (gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender.capitalize()),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedGender = value;
                  _checkWomenHealthEligibility();
                });
              }
            },
          ),
          const SizedBox(height: 16.0),
          ListTile(
            title: const Text('Date of Birth'),
            subtitle: Text(_selectedDate.toString().split(' ')[0]),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                    _checkWomenHealthEligibility();
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.userProfile.name = _nameController.text;
                widget.userProfile.phone = _phoneController.text;
                widget.userProfile.gender = _selectedGender;
                widget.userProfile.dateOfBirth = _selectedDate;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: const Text('Update Profile'),
          ),
          if (_isFemaleAbove18) ...[
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final tabController = DefaultTabController.of(context);
                if (tabController != null) {
                  tabController.animateTo(4);
                }
              },
              child: const Text('Go to Women\'s Health'),
            ),
          ],
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
