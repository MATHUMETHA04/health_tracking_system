import 'package:flutter/material.dart';

void main() {
  runApp(const DoctorDashboardApp());
}

class DoctorDashboardApp extends StatelessWidget {
  const DoctorDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const DoctorDashboardScreen(),
    );
  }
}

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Profile Section
            DoctorProfileCard(),
            SizedBox(height: 16),
            // Schemes for Doctor
            SchemesSection(),
            SizedBox(height: 16),
            // Appointments Grid
            AppointmentsGrid(),
            SizedBox(height: 16),
            // Patient Health Records
            PatientHealthRecords(),
            SizedBox(height: 16),
            // Vaccination Schedules
            VaccinationSchedules(),
            SizedBox(height: 16),
            // Upcoming Schedules
            UpcomingSchedules(),
            SizedBox(height: 16),
            // Doctor Availability
            DoctorAvailability(),
          ],
        ),
      ),
    );
  }
}

// Doctor Profile Card
class DoctorProfileCard extends StatelessWidget {
  const DoctorProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dr. John Smith',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Cardiologist',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            const Text(
              'Experience: 15 Years',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hospital: City General Hospital',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            const Text(
              'Degree: MBBS, MD (Cardiology)',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // View certificate action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('View Certificate'),
            ),
          ],
        ),
      ),
    );
  }
}

// Schemes for Doctor Section
class SchemesSection extends StatelessWidget {
  const SchemesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schemes for Doctors',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ExpansionTile(
              title: Text('Government Health Scheme'),
              children: [
                ListTile(
                  title: Text('Details'),
                  subtitle: Text(
                    'Subsidized healthcare for underprivileged patients.',
                  ),
                ),
                ListTile(
                  title: Text('Benefits'),
                  subtitle: Text('Tax benefits and funding for equipment.'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Private Insurance Scheme'),
              children: [
                ListTile(
                  title: Text('Details'),
                  subtitle: Text(
                    'Partnership with top insurance providers for patient care.',
                  ),
                ),
                ListTile(
                  title: Text('Benefits'),
                  subtitle: Text('Higher reimbursement rates for services.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Appointments Grid
class AppointmentsGrid extends StatelessWidget {
  const AppointmentsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
              children: [
                AppointmentCard(
                  patientName: 'Alice Brown',
                  time: '10:00 AM',
                  status: 'Confirmed',
                  onTap: () {},
                ),
                AppointmentCard(
                  patientName: 'Bob Wilson',
                  time: '11:30 AM',
                  status: 'Pending',
                  onTap: () {},
                ),
                AppointmentCard(
                  patientName: 'Clara Davis',
                  time: '2:00 PM',
                  status: 'Confirmed',
                  onTap: () {},
                ),
                AppointmentCard(
                  patientName: 'David Lee',
                  time: '3:15 PM',
                  status: 'Cancelled',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String time;
  final String status;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.patientName,
    required this.time,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text('Time: $time'),
              const SizedBox(height: 4),
              Text(
                'Status: $status',
                style: TextStyle(
                  color:
                      status == 'Confirmed'
                          ? Colors.green
                          : status == 'Pending'
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Patient Health Records
class PatientHealthRecords extends StatelessWidget {
  const PatientHealthRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Patient Health Records',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('John Doe'),
              subtitle: const Text('Record: BP 120/80, Verified'),
              trailing: const Icon(Icons.check_circle, color: Colors.green),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Jane Roe'),
              subtitle: const Text('Record: Glucose 90, Pending'),
              trailing: const Icon(Icons.hourglass_empty, color: Colors.orange),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// Vaccination Schedules
class VaccinationSchedules extends StatelessWidget {
  const VaccinationSchedules({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vaccination Schedules',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Emily Clark'),
              subtitle: const Text('Vaccine: MMR, Date: 2025-05-10'),
              trailing: const Icon(Icons.vaccines),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Michael Tan'),
              subtitle: const Text('Vaccine: Flu Shot, Date: 2025-06-15'),
              trailing: const Icon(Icons.vaccines),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// Upcoming Schedules
class UpcomingSchedules extends StatelessWidget {
  const UpcomingSchedules({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Schedules',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Surgery Consultation'),
              subtitle: const Text('Date: 2025-05-02, Time: 9:00 AM'),
              trailing: const Icon(Icons.event),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Patient Follow-up'),
              subtitle: const Text('Date: 2025-05-03, Time: 1:00 PM'),
              trailing: const Icon(Icons.event),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// Doctor Availability
class DoctorAvailability extends StatelessWidget {
  const DoctorAvailability({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor Availability',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text('Monday - Friday'),
              subtitle: Text('9:00 AM - 5:00 PM'),
              trailing: Icon(Icons.access_time),
            ),
            ListTile(
              title: Text('Saturday'),
              subtitle: Text('10:00 AM - 2:00 PM'),
              trailing: Icon(Icons.access_time),
            ),
            ListTile(
              title: Text('Sunday'),
              subtitle: Text('Unavailable'),
              trailing: Icon(Icons.block, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
