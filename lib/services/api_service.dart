import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart' as models;
import '../models/appoinment.dart';
import '../models/health_record.dart';
import '../models/menstrual_log.dart';

class ApiService {
  // TODO: Move this to a configuration file
  static const String baseUrl = 'https://your-api'; // Replace with your API URL

  Future<models.MutableUser> getUserProfile() async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final response = await http.get(
        Uri.parse('$baseUrl/patient/profile'),
        headers: {'Authorization': 'Bearer ${await user.getIdToken()}'},
      );

      if (response.statusCode == 200) {
        return models.MutableUser.fromJson(jsonDecode(response.body));
      }
      throw Exception('Failed to load profile: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<List<Appointment>> getAppointments() async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final response = await http.get(
        Uri.parse('$baseUrl/patient/appointments'),
        headers: {'Authorization': 'Bearer ${await user.getIdToken()}'},
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => Appointment.fromJson(e))
            .toList();
      }
      throw Exception('Failed to load appointments: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }

  Future<List<HealthRecord>> getHealthRecords() async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final response = await http.get(
        Uri.parse('$baseUrl/patient/health-records'),
        headers: {'Authorization': 'Bearer ${await user.getIdToken()}'},
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => HealthRecord.fromJson(e))
            .toList();
      }
      throw Exception('Failed to load health records: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load health records: $e');
    }
  }

  Future<void> sendSosAlert(String message) async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final response = await http.post(
        Uri.parse('$baseUrl/patient/sos'),
        headers: {
          'Authorization': 'Bearer ${await user.getIdToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send SOS alert: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to send SOS alert: $e');
    }
  }

  Future<List<MenstrualLog>> getMenstrualLogs() async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final response = await http.get(
        Uri.parse('$baseUrl/patient/menstrual-logs'),
        headers: {'Authorization': 'Bearer ${await user.getIdToken()}'},
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => MenstrualLog.fromJson(e))
            .toList();
      }
      throw Exception('Failed to load menstrual logs: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to load menstrual logs: $e');
    }
  }

  Future<void> addMenstrualLog(MenstrualLog log) async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final response = await http.post(
        Uri.parse('$baseUrl/patient/menstrual-logs'),
        headers: {
          'Authorization': 'Bearer ${await user.getIdToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(log.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add menstrual log: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add menstrual log: $e');
    }
  }
}
