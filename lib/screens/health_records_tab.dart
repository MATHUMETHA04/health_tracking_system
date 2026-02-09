import 'package:flutter/material.dart';
import '../models/health_record.dart';

class HealthRecordsTab extends StatefulWidget {
  const HealthRecordsTab({Key? key}) : super(key: key);

  @override
  _HealthRecordsTabState createState() => _HealthRecordsTabState();
}

class _HealthRecordsTabState extends State<HealthRecordsTab> {
  final List<HealthRecord> _healthRecords = [];
  final _diagnosisController = TextEditingController();
  final _medicationsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    setState(() {
      _healthRecords.addAll([
        HealthRecord(
          recordId: '1',
          diagnosis: 'Common Cold',
          medications: 'Paracetamol 500mg',
          updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        HealthRecord(
          recordId: '2',
          diagnosis: 'Hypertension',
          medications: 'Amlodipine 5mg',
          updatedAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
      ]);
    });
  }

  void _addHealthRecord() {
    if (_diagnosisController.text.isNotEmpty) {
      final record = HealthRecord(
        recordId: DateTime.now().millisecondsSinceEpoch.toString(),
        diagnosis: _diagnosisController.text,
        medications: _medicationsController.text,
        updatedAt: DateTime.now(),
      );

      setState(() {
        _healthRecords.add(record);
        _diagnosisController.clear();
        _medicationsController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Health record added successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _medicationsController.dispose();
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
            'Add New Health Record',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _diagnosisController,
            decoration: const InputDecoration(
              labelText: 'Diagnosis',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _medicationsController,
            decoration: const InputDecoration(
              labelText: 'Medications',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addHealthRecord,
            child: const Text('Add Health Record'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Health Records History',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (_healthRecords.isEmpty)
            const Center(child: Text('No health records found')),
          ..._healthRecords.map(
            (record) => Card(
              child: ListTile(
                title: Text(record.diagnosis),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Medications: ${record.medications}'),
                    Text(
                      'Updated: ${record.updatedAt.toString().split(' ')[0]}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
