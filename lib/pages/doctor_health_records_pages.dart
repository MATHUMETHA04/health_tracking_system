import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/auth_button.dart';

class DoctorHealthRecordsPage extends StatefulWidget {
  const DoctorHealthRecordsPage({super.key});

  @override
  State<DoctorHealthRecordsPage> createState() => _DoctorHealthRecordsPageState();
}

class _DoctorHealthRecordsPageState extends State<DoctorHealthRecordsPage> {
  void _sendNotification(String patient, String type, String date, String time) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification sent to $patient for $type on $date at $time'),
      ),
    );
  }

  void _toggleVerification(String patient, int index) {
    setState(() {
      patientHealthRecords[patient]![index]['verified'] =
          !patientHealthRecords[patient]![index]['verified'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Record ${patientHealthRecords[patient]![index]['verified'] ? 'verified' : 'unverified'} for $patient',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample data
    if (patientHealthRecords.isEmpty) {
      patientHealthRecords['John Doe'] = [
        {
          'type': 'Vaccination',
          'name': 'COVID-19',
          'date': '2025-03-15',
          'verified': false,
        },
        {
          'type': 'Checkup',
          'name': 'General Health',
          'date': '2025-04-01',
          'verified': true,
        },
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Health Records'),
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
          itemCount: patientHealthRecords.keys.length,
          itemBuilder: (context, index) {
            String patient = patientHealthRecords.keys.elementAt(index);
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ExpansionTile(
                title: Text(
                  patient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
                children: [
                  ...patientHealthRecords[patient]!.asMap().entries.map((entry) {
                    int idx = entry.key;
                    var record = entry.value;
                    return ListTile(
                      title: Text('${record['type']}: ${record['name']}'),
                      subtitle: Text('Date: ${record['date']} | Verified: ${record['verified']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              record['verified'] ? Icons.check_circle : Icons.check_circle_outline,
                              color: record['verified'] ? Colors.green : Colors.grey,
                            ),
                            onPressed: () => _toggleVerification(patient, idx),
                          ),
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AuthButton(
                          text: 'Notify Vaccine',
                          color: Colors.blue.shade700,
                          onPressed: () => _sendNotification(patient, 'Vaccine', '2025-06-01', '10:00 AM'),
                        ),
                        AuthButton(
                          text: 'Notify Checkup',
                          color: Colors.blue.shade700,
                          onPressed: () => _sendNotification(patient, 'Checkup', '2025-05-15', '2:00 PM'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}