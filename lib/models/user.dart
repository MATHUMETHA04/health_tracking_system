// Simulated user database
Map<String, Map<String, String>> users = {'doctor': {}, 'patient': {}};

// Simulated patient profiles
Map<String, Map<String, String>> patientProfiles = {};

// Simulated doctor profiles
Map<String, Map<String, String>> doctorProfiles = {};

// Simulated appointments
List<Map<String, dynamic>> appointments = [];

// Simulated patient health records
Map<String, List<Map<String, dynamic>>> patientHealthRecords = {};

// Simulated SOS alerts
List<Map<String, String>> sosAlerts = [];

class MutableUser {
  String name;
  String phone;
  String gender;
  DateTime dateOfBirth;

  MutableUser({
    required this.name,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
  });

  factory MutableUser.fromJson(Map<String, dynamic> json) {
    return MutableUser(
      name: json['name'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
    };
  }
}
