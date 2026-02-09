import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/auth_button.dart';

class AppointmentsPage extends StatefulWidget {
  final String username;
  final String role;

  const AppointmentsPage({super.key, required this.username, required this.role});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedHospitalType = 'All';
  String _selectedTimeSlot = 'All';

  // Initialize appointments list
  List<Map<String, dynamic>> appointments = [];

  final List<Map<String, dynamic>> availableDoctors = [
    {
      'name': 'Dr. Smith',
      'specialization': 'Cardiologist',
      'fees': 1500,
      'hospitalType': 'Private',
      'hospital': 'City Hospital',
      'schedule': [
        {'day': 'Monday', 'time': '10:00 AM - 12:00 PM'},
        {'day': 'Wednesday', 'time': '2:00 PM - 4:00 PM'},
      ]
    },
    {
      'name': 'Dr. Jones',
      'specialization': 'General Physician',
      'fees': 800,
      'hospitalType': 'Government',
      'hospital': 'General Hospital',
      'schedule': [
        {'day': 'Tuesday', 'time': '9:00 AM - 11:00 AM'},
        {'day': 'Thursday', 'time': '3:00 PM - 5:00 PM'},
      ]
    },
    {
      'name': 'Dr. Brown',
      'specialization': 'Dermatologist',
      'fees': 1200,
      'hospitalType': 'Private',
      'hospital': 'Skin Care Center',
      'schedule': [
        {'day': 'Friday', 'time': '11:00 AM - 1:00 PM'},
        {'day': 'Saturday', 'time': '10:00 AM - 12:00 PM'},
      ]
    },
  ];

  final List<Map<String, dynamic>> hospitals = [
    {'name': 'City Hospital', 'type': 'Private', 'location': 'Downtown'},
    {'name': 'General Hospital', 'type': 'Government', 'location': 'City Center'},
    {'name': 'Skin Care Center', 'type': 'Private', 'location': 'Medical District'},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with some sample appointments
    appointments = [
      {
        'patient': 'John Doe',
        'doctor': 'Dr. Smith',
        'date': '2025-05-01',
        'type': 'Call',
        'status': 'Pending',
        'fees': 1500,
        'hospitalType': 'Private'
      },
      {
        'patient': 'Jane Smith',
        'doctor': 'Dr. Jones',
        'date': '2025-05-02',
        'type': 'In-Person',
        'status': 'Accepted',
        'fees': 800,
        'hospitalType': 'Government'
      }
    ];
  }

  void _requestAppointment(String type) {
    setState(() {
      appointments.add({
        'patient': widget.username,
        'doctor': 'Dr. Smith',
        'date': '2025-05-${appointments.length + 1}',
        'type': type,
        'status': 'Pending',
        'fees': 1500,
        'hospitalType': 'Private'
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$type appointment requested!')),
    );
  }

  void _updateAppointmentStatus(int index, String status) {
    setState(() {
      appointments[index]['status'] = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment $status!')),
    );
  }

  List<Map<String, dynamic>> _getFilteredDoctors() {
    return availableDoctors.where((doctor) {
      bool matchesSearch = doctor['name'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          doctor['specialization'].toLowerCase().contains(_searchController.text.toLowerCase()) ||
          doctor['hospital'].toLowerCase().contains(_searchController.text.toLowerCase());
      
      bool matchesHospitalType = _selectedHospitalType == 'All' || 
          doctor['hospitalType'] == _selectedHospitalType;
      
      return matchesSearch && matchesHospitalType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> doctorSchedules = [
      {'date': '2025-05-01', 'time': '10:00 AM - 12:00 PM'},
      {'date': '2025-05-02', 'time': '2:00 PM - 4:00 PM'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: widget.role == 'Doctor' ? Colors.blue.shade700 : Colors.green.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.role == 'Doctor'
                ? [Colors.blue, Colors.blueAccent]
                : [Colors.green, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.role == 'Patient'
              ? _buildPatientView()
              : _buildDoctorView(doctorSchedules),
        ),
      ),
    );
  }

  Widget _buildPatientView() {
    List<Map<String, dynamic>> patientAppointments = appointments
        .where((appt) => appt['patient'] == widget.username)
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search doctors, specializations, or hospitals',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedHospitalType,
                          items: ['All', 'Private', 'Government']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedHospitalType = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Hospital Type',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Available Doctors Section
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
            itemCount: _getFilteredDoctors().length,
            itemBuilder: (context, index) {
              final doctor = _getFilteredDoctors()[index];
              return Card(
                child: ExpansionTile(
                  title: Text(doctor['name']),
                  subtitle: Text('${doctor['specialization']} - ${doctor['hospital']}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fees: ₹${doctor['fees']}'),
                          Text('Hospital Type: ${doctor['hospitalType']}'),
                          const SizedBox(height: 10),
                          const Text('Available Schedule:'),
                          ...doctor['schedule'].map<Widget>((slot) => Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                                child: Text('${slot['day']}: ${slot['time']}'),
                              )),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AuthButton(
                                text: 'Book Call',
                                color: Colors.green.shade700,
                                onPressed: () => _requestAppointment('Call'),
                              ),
                              AuthButton(
                                text: 'Book Chat',
                                color: Colors.green.shade700,
                                onPressed: () => _requestAppointment('Chat'),
                              ),
                              AuthButton(
                                text: 'Book In-Person',
                                color: Colors.green.shade700,
                                onPressed: () => _requestAppointment('In-Person'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Your Appointments Section
          Text(
            'Your Appointments',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: patientAppointments.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Dr. ${patientAppointments[index]['doctor']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${patientAppointments[index]['date']}'),
                      Text('Type: ${patientAppointments[index]['type']}'),
                      Text('Status: ${patientAppointments[index]['status']}'),
                      Text('Fees: ₹${patientAppointments[index]['fees']}'),
                      Text('Hospital Type: ${patientAppointments[index]['hospitalType']}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorView(List<Map<String, dynamic>> schedules) {
    List<Map<String, dynamic>> doctorAppointments = appointments
        .where((appt) => appt['doctor'] == widget.username)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Schedule',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text('Date: ${schedules[index]['date']}'),
                  subtitle: Text('Time: ${schedules[index]['time']}'),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Appointment Requests',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: doctorAppointments.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text('Patient: ${doctorAppointments[index]['patient']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${doctorAppointments[index]['date']}'),
                      Text('Type: ${doctorAppointments[index]['type']}'),
                      Text('Status: ${doctorAppointments[index]['status']}'),
                      Text('Fees: ₹${doctorAppointments[index]['fees']}'),
                      Text('Hospital Type: ${doctorAppointments[index]['hospitalType']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (doctorAppointments[index]['status'] == 'Pending') ...[
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _updateAppointmentStatus(index, 'Accepted'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => _updateAppointmentStatus(index, 'Rejected'),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}