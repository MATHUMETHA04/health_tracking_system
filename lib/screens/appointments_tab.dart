import 'package:flutter/material.dart';
import '../models/appoinment.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({Key? key}) : super(key: key);

  @override
  _AppointmentsTabState createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  final List<Appointment> _appointments = [];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _doctorNameController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    setState(() {
      _appointments.addAll([
        Appointment(
          appointmentId: '1',
          doctorName: 'Dr. Smith',
          date: DateTime.now().add(const Duration(days: 2)),
          time: '10:00 AM',
          status: 'Scheduled',
        ),
        Appointment(
          appointmentId: '2',
          doctorName: 'Dr. Johnson',
          date: DateTime.now().add(const Duration(days: 5)),
          time: '02:30 PM',
          status: 'Confirmed',
        ),
      ]);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  void _scheduleAppointment() {
    if (_doctorNameController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null) {
      final appointment = Appointment(
        appointmentId: DateTime.now().millisecondsSinceEpoch.toString(),
        doctorName: _doctorNameController.text,
        date: _selectedDate!,
        time: _selectedTime!.format(context),
        status: 'Scheduled',
      );

      setState(() {
        _appointments.add(appointment);
        _doctorNameController.clear();
        _selectedDate = null;
        _selectedTime = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment scheduled successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Schedule New Appointment',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _doctorNameController,
            decoration: const InputDecoration(
              labelText: 'Doctor Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Select Date'),
            subtitle: Text(
              _selectedDate?.toString().split(' ')[0] ?? 'Not selected',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: _selectDate,
            ),
          ),
          ListTile(
            title: const Text('Select Time'),
            subtitle: Text(_selectedTime?.format(context) ?? 'Not selected'),
            trailing: IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: _selectTime,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _scheduleAppointment,
            child: const Text('Schedule Appointment'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Upcoming Appointments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (_appointments.isEmpty)
            const Center(child: Text('No appointments scheduled')),
          ..._appointments.map(
            (appt) => Card(
              child: ListTile(
                title: Text(appt.doctorName),
                subtitle: Text(
                  '${appt.date.toString().split(' ')[0]} ${appt.time}',
                ),
                trailing: Chip(
                  label: Text(
                    appt.status,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      appt.status == 'Confirmed' ? Colors.green : Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
