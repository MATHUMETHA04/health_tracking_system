class HealthRecord {
  final String recordId;
  final String diagnosis;
  final String medications;
  final DateTime updatedAt;

  HealthRecord({
    required this.recordId,
    required this.diagnosis,
    required this.medications,
    required this.updatedAt,
  });

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      recordId: json['recordId'],
      diagnosis: json['diagnosis'],
      medications: json['medications'].join(', '),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
