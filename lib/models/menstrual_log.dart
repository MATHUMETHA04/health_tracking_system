class MenstrualLog {
  final String logId;
  final DateTime startDate;
  final DateTime endDate;
  final String flow;
  final String symptoms;

  MenstrualLog({
    required this.logId,
    required this.startDate,
    required this.endDate,
    required this.flow,
    required this.symptoms,
  });

  factory MenstrualLog.fromJson(Map<String, dynamic> json) {
    return MenstrualLog(
      logId: json['logId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      flow: json['flow'],
      symptoms: json['symptoms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logId': logId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'flow': flow,
      'symptoms': symptoms,
    };
  }
}
