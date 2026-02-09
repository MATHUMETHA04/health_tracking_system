import 'package:flutter/material.dart';

class SOSAlertsPage extends StatelessWidget {
  const SOSAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // In real app, this would show live alerts or push notifications
    return Scaffold(
      appBar: AppBar(title: const Text('SOS Alerts')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text("No current SOS alerts", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
