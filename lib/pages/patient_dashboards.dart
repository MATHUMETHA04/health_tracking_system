import 'package:flutter/material.dart';
import 'appointments_page.dart';
import 'vaccination_page.dart';
import 'sos_page.dart';
import 'profile_page.dart';
import 'health_records_page.dart';
import 'government_schemes_page.dart';
import '../widgets/health_tip.dart';
import '../widgets/chatbot.dart';

class PatientDashboard extends StatelessWidget {
  final String username;

  const PatientDashboard({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dashboardItems = [
      {
        'title': 'Appointments',
        'icon': Icons.calendar_today,
        'page': AppointmentsPage(username: username),
      },
      {
        'title': 'Vaccination Schedules',
        'icon': Icons.vaccines,
        'page': const VaccinationPage(),
      },
      {
        'title': 'SOS Alerts',
        'icon': Icons.warning,
        'page': const SosPage(),
      },
      {
        'title': 'Profile',
        'icon': Icons.person,
        'page': ProfilePage(username: username),
      },
      {
        'title': 'Health Records',
        'icon': Icons.medical_services,
        'page': const HealthRecordsPage(),
      },
      {
        'title': 'Government Schemes',
        'icon': Icons.account_balance,
        'page': const GovernmentSchemesPage(),
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.greenAccent],
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
                  'Welcome, $username',
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
                              color: Colors.green.shade700,
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
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const HealthTipCarousel(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ChatbotButton(username: username),
    );
  }
}