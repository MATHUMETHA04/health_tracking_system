class Appointment {
  final String appointmentId;
  final String doctorName;
  final DateTime date;
  final String time;
  final String status;

  Appointment({
    required this.appointmentId,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      doctorName: json['doctorName'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      status: json['status'],
    );
  }
}
