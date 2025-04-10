class SensorDataModel {
  final DateTime timestamp;
  final int value;

  SensorDataModel({
    required this.timestamp,
    required this.value,
  });

  factory SensorDataModel.fromJson(Map<String, dynamic> json) {
    return SensorDataModel(
      timestamp: DateTime.parse(json['timestamp']),
      value: json['value'],
    );
  }
}
