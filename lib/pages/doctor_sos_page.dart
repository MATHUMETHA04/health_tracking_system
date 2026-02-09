import 'package:flutter/material.dart';
import '../models/user.dart';

class DoctorSosPage extends StatelessWidget {
  const DoctorSosPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample SOS alerts
    if (sosAlerts.isEmpty) {
      sosAlerts.addAll([
        {
          'patient': 'John Doe',
          'location': '123 Main St',
          'contact': '9876543210',
          'time': '2025-04-30 10:00 AM',
        },
        {
          'patient': 'Jane Smith',
          'location': '456 Park Ave',
          'contact': '9876543211',
          'time': '2025-04-30 11:00 AM',
        },
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Alerts'),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: sosAlerts.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ListTile(
                title: Text('Patient: ${sosAlerts[index]['patient']}'),
                subtitle: Text(
                  'Location: ${sosAlerts[index]['location']}\nContact: ${sosAlerts[index]['contact']}\nTime: ${sosAlerts[index]['time']}',
                ),
                leading: const Icon(Icons.warning, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}