import 'package:flutter/material.dart';
import '../models/user.dart' as models;
import 'profile_tab.dart';
import 'appointments_tab.dart';
import 'health_records_tab.dart';
import 'sos_tab.dart';
import 'womens_health_tab.dart';

class PatientDashboard extends StatefulWidget {
  final String username;
  final String gender;
  final DateTime dateOfBirth;

  const PatientDashboard({
    Key? key,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
  }) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  models.MutableUser? userProfile;
  bool isFemaleAbove18 = false;

  @override
  void initState() {
    super.initState();
    _initializeUserProfile();
  }

  void _initializeUserProfile() {
    setState(() {
      userProfile = models.MutableUser(
        name: widget.username,
        phone: '+1234567890', // Default phone number
        gender: widget.gender,
        dateOfBirth: widget.dateOfBirth,
      );
      final age =
          DateTime.now().difference(userProfile!.dateOfBirth).inDays ~/ 365;
      isFemaleAbove18 =
          userProfile!.gender.toLowerCase() == 'female' && age > 18;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: isFemaleAbove18 ? 5 : 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Patient Dashboard'),
          bottom: TabBar(
            tabs: [
              const Tab(text: 'Profile'),
              const Tab(text: 'Appointments'),
              const Tab(text: 'Health Records'),
              const Tab(text: 'SOS'),
              if (isFemaleAbove18) const Tab(text: "IIKYK"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
            ),
          ],
        ),
        body:
            userProfile == null
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                  children: [
                    ProfileTab(userProfile: userProfile!),
                    AppointmentsTab(),
                    HealthRecordsTab(),
                    SOSTab(),
                    if (isFemaleAbove18) const IKYKTab(),
                  ],
                ),
      ),
    );
  }
}
