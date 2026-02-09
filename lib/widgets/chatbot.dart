import 'package:flutter/material.dart';

class ChatbotButton extends StatelessWidget {
  final String username;

  const ChatbotButton({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green.shade700,
      child: const Icon(Icons.chat),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ChatbotDialog(username: username),
        );
      },
    );
  }
}

class ChatbotDialog extends StatefulWidget {
  final String username;

  const ChatbotDialog({super.key, required this.username});

  @override
  State<ChatbotDialog> createState() => _ChatbotDialogState();
}

class _ChatbotDialogState extends State<ChatbotDialog> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _handleQuery(String query) {
    String response = '';
    query = query.toLowerCase();

    if (query.contains('health') || query.contains('disease')) {
      if (query.contains('diabetes')) {
        response =
            'For diabetes, maintain a balanced diet, monitor blood sugar, and exercise regularly. Government schemes like Ayushman Bharat can cover related hospitalizations.';
      } else if (query.contains('tuberculosis') || query.contains('tb')) {
        response =
            'The National TB Elimination Programme provides free diagnosis, treatment, and nutritional support for TB patients.';
      } else {
        response = 'Please specify the health condition for detailed advice.';
      }
    } else if (query.contains('scheme') || query.contains('government')) {
      response =
          'Available schemes include Ayushman Bharat (hospitalization coverage), Pradhan Mantri Surakshit Matritva Abhiyan (pregnant women health check-ups), and National TB Elimination Programme (TB treatment).';
    } else {
      response = 'I can help with health queries or government schemes. Please ask something specific!';
    }

    setState(() {
      _messages.add({'sender': 'user', 'text': query});
      _messages.add({'sender': 'bot', 'text': response});
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Health Assistant'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  bool isUser = _messages[index]['sender'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.green.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _messages[index]['text']!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask about health or schemes...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onSubmitted: _handleQuery,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}