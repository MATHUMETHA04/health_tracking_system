import 'package:flutter/material.dart';

class VaccinationPage extends StatelessWidget {
  const VaccinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recentVaccinations = [
      {'name': 'COVID-19', 'date': '2025-03-15'},
      {'name': 'Flu', 'date': '2025-02-10'},
    ];
    final List<Map<String, String>> upcomingVaccinations = [
      {'name': 'Hepatitis B', 'date': '2025-06-01', 'time': '10:00 AM'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination Schedules'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Vaccinations',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: recentVaccinations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(recentVaccinations[index]['name']!),
                        subtitle: Text('Date: ${recentVaccinations[index]['date']}'),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Upcoming Vaccinations',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: upcomingVaccinations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(upcomingVaccinations[index]['name']!),
                        subtitle: Text(
                          'Date: ${upcomingVaccinations[index]['date']} | Time: ${upcomingVaccinations[index]['time']}',
                        ),
                        trailing: const Icon(Icons.notifications, color: Colors.green),
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