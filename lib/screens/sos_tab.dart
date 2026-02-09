import 'package:flutter/material.dart';

class SOSTab extends StatefulWidget {
  const SOSTab({Key? key}) : super(key: key);

  @override
  _SOSTabState createState() => _SOSTabState();
}

class _SOSTabState extends State<SOSTab> {
  final _messageController = TextEditingController();
  final List<Map<String, dynamic>> _emergencyContacts = [
    {'name': 'Emergency Services', 'number': '911'},
    {'name': 'Family Doctor', 'number': '+1234567890'},
    {'name': 'Nearest Hospital', 'number': '+1987654321'},
  ];

  void _sendSos() {
    if (_messageController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('SOS alert sent to emergency contacts!'),
          backgroundColor: Colors.red,
        ),
      );
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
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
            'Emergency Contacts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._emergencyContacts.map(
            (contact) => Card(
              child: ListTile(
                title: Text(contact['name']),
                subtitle: Text(contact['number']),
                trailing: IconButton(
                  icon: const Icon(Icons.phone, color: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${contact['name']}...'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Send SOS Alert',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Emergency Message',
              border: OutlineInputBorder(),
              hintText: 'Describe your emergency situation...',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _sendSos,
            child: const Text(
              'SEND SOS ALERT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
