import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class AppointmentsPage extends StatefulWidget {
  final String username;

  const AppointmentsPage({super.key, required this.username});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final List<Map<String, dynamic>> recentAppointments = [
    {'date': '2025-05-01', 'doctor': 'Dr. Smith', 'type': 'Call', 'fees': 1500, 'hospitalType': 'Private'},
    {'date': '2025-04-28', 'doctor': 'Dr. Jones', 'type': 'Chat', 'fees': 800, 'hospitalType': 'Government'},
  ];

  final List<Map<String, dynamic>> availableDoctors = [
    {'name': 'Dr. Smith', 'specialization': 'Cardiologist', 'fees': 1500, 'hospitalType': 'Private'},
    {'name': 'Dr. Jones', 'specialization': 'General Physician', 'fees': 800, 'hospitalType': 'Government'},
    {'name': 'Dr. Brown', 'specialization': 'Dermatologist', 'fees': 1200, 'hospitalType': 'Private'},
    {'name': 'Dr. Wilson', 'specialization': 'Pediatrician', 'fees': 600, 'hospitalType': 'Government'},
  ];

  void _requestAppointment(String type) {
    setState(() {
      recentAppointments.add({
        'date': '2025-05-${recentAppointments.length + 1}',
        'doctor': 'Dr. New',
        'type': type,
        'fees': 1000,
        'hospitalType': 'Private',
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$type appointment requested!')),
    );
  }

  Map<String, dynamic> _findMinimumFees() {
    var privateMin = availableDoctors
        .where((doc) => doc['hospitalType'] == 'Private')
        .reduce((curr, next) => curr['fees'] < next['fees'] ? curr : next);
    
    var governmentMin = availableDoctors
        .where((doc) => doc['hospitalType'] == 'Government')
        .reduce((curr, next) => curr['fees'] < next['fees'] ? curr : next);
    
    return {
      'private': privateMin,
      'government': governmentMin,
    };
  }

  @override
  Widget build(BuildContext context) {
    final minFees = _findMinimumFees();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Doctor Fee Comparison',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minimum Fees',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Text('Private Hospital: ₹${minFees['private']['fees']} (${minFees['private']['name']})'),
                      Text('Government Hospital: ₹${minFees['government']['fees']} (${minFees['government']['name']})'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Available Doctors',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableDoctors.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(availableDoctors[index]['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(availableDoctors[index]['specialization']),
                          Text('Fees: ₹${availableDoctors[index]['fees']}'),
                          Text('Hospital Type: ${availableDoctors[index]['hospitalType']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Recent Appointments',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentAppointments.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Dr. ${recentAppointments[index]['doctor']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${recentAppointments[index]['date']}'),
                          Text('Type: ${recentAppointments[index]['type']}'),
                          Text('Fees: ₹${recentAppointments[index]['fees']}'),
                          Text('Hospital Type: ${recentAppointments[index]['hospitalType']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Request New Appointment',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AuthButton(
                    text: 'Call',
                    color: Colors.green.shade700,
                    onPressed: () => _requestAppointment('Call'),
                  ),
                  AuthButton(
                    text: 'Chat',
                    color: Colors.green.shade700,
                    onPressed: () => _requestAppointment('Chat'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}