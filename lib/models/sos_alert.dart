class SOSAlert {
  final String alertId;
  final String message;
  final DateTime createdAt;

  SOSAlert({
    required this.alertId,
    required this.message,
    required this.createdAt,
  });

  factory SOSAlert.fromJson(Map<String, dynamic> json) {
    return SOSAlert(
      alertId: json['alertId'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
