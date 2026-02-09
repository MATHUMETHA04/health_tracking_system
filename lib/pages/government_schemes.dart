import 'package:flutter/material.dart';

class GovernmentSchemesPage extends StatelessWidget {
  const GovernmentSchemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> schemes = [
      {
        'name': 'Ayushman Bharat',
        'purpose': 'Provides free health coverage up to ₹5 lakh per family per year for secondary and tertiary care hospitalization.',
        'eligibility': 'Targets economically disadvantaged families based on SECC 2011 data.'
      },
      {
        'name': 'Pradhan Mantri Surakshit Matritva Abhiyan',
        'purpose': 'Ensures free health check-ups for pregnant women to reduce maternal and infant mortality.',
        'eligibility': 'All pregnant women in their 2nd/3rd trimesters.'
      },
      {
        'name': 'National TB Elimination Programme',
        'purpose': 'Offers free diagnosis, treatment, and nutritional support for TB patients.',
        'eligibility': 'All individuals diagnosed with tuberculosis.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Schemes'),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: schemes.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schemes[index]['name']!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Purpose: ${schemes[index]['purpose']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Eligibility: ${schemes[index]['eligibility']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}