import 'package:flutter/material.dart';
import 'appointment_doctor.dart';
import 'doctor_health_records_page.dart';
import 'doctor_profile_page.dart';
import 'doctor_sos_page.dart';

class DoctorDashboard extends StatelessWidget {
  final String username;

  const DoctorDashboard({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dashboardItems = [
      {
        'title': 'Appointments',
        'icon': Icons.calendar_today,
        'page': AppointmentsPage(username: username, role: 'Doctor'),
      },
      {
        'title': 'Profile',
        'icon': Icons.person,
        'page': DoctorProfilePage(username: username),
      },
      {
        'title': 'Health Records',
        'icon': Icons.medical_services,
        'page': const DoctorHealthRecordsPage(),
      },
      {
        'title': 'SOS Alerts',
        'icon': Icons.warning,
        'page': const DoctorSosPage(),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome, Dr. $username',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: dashboardItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => dashboardItems[index]['page'],
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              dashboardItems[index]['icon'],
                              size: 40,
                              color: Colors.blue.shade700,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              dashboardItems[index]['title'],
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}