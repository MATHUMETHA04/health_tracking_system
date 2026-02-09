import 'package:flutter/material.dart';

class GovernmentSchemesPage extends StatelessWidget {
  const GovernmentSchemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> schemes = [
      {
        'title': 'Ayushman Bharat',
        'description': 'Health insurance scheme providing coverage up to ₹5 lakhs per family per year',
        'icon': Icons.health_and_safety,
      },
      {
        'title': 'Pradhan Mantri Jan Arogya Yojana',
        'description': 'National Health Protection Scheme covering secondary and tertiary care hospitalization',
        'icon': Icons.local_hospital,
      },
      {
        'title': 'National Health Mission',
        'description': 'Universal access to equitable, affordable and quality health care services',
        'icon': Icons.medical_services,
      },
      {
        'title': 'Rashtriya Swasthya Bima Yojana',
        'description': 'Health insurance for Below Poverty Line families',
        'icon': Icons.medical_information,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Health Schemes'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: schemes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        schemes[index]['icon'],
                        color: Colors.green,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          schemes[index]['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    schemes[index]['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 