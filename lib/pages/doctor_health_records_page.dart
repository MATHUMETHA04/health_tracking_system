import 'package:flutter/material.dart';

class DoctorHealthRecordsPage extends StatelessWidget {
  const DoctorHealthRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
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
          itemCount: 5, // Example count
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: ListTile(
                title: Text('Patient ${index + 1}'),
                subtitle: Text('Last Visit: 2025-05-${index + 1}'),
                trailing: IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    // Navigate to patient's detailed health record
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 