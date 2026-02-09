import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/role_selection_screen[1].dart';

void main() async {
  // Ensure that widget binding is initialized before Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // After Firebase is initialized, run your app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor & Patient App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(fontSize: 18, color: Colors.white70),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 14, 13, 13),
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}