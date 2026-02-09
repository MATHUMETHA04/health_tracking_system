import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class SosPage extends StatelessWidget {
  const SosPage({super.key});

  void _sendSosAlert(BuildContext context) {
    // Simulate sending alert to hospitals and contacts
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS Alert sent to nearby hospitals and emergency contacts!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Alerts'),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning, size: 80, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  'Emergency SOS Alert',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Send an alert to nearby hospitals and emergency contacts.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                AuthButton(
                  text: 'Send SOS Alert',
                  color: Colors.red.shade700,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm SOS Alert'),
                        content: const Text('Are you sure you want to send an emergency alert?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _sendSosAlert(context);
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}