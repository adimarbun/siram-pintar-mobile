class ScheduleRequestModel {
  final int plantId;
  final int deviceId;
  final String wateringTime;
  final int duration;
  final String schedule;
  final String frequency;
  final int? dayOfMonth;
  final int? dayOfWeek; 
  final String? onceOnDate;
  final int? moistureThreshold;
  final bool active;

  ScheduleRequestModel({
    required this.plantId,
    required this.deviceId,
    required this.wateringTime,
    required this.duration,
    required this.schedule,
    required this.frequency,
    this.dayOfMonth,
    this.dayOfWeek, 
    this.onceOnDate,
    this.moistureThreshold,
    required this.active,
  });

  Map<String, dynamic> toJson() {
    return {
      "plant_id": plantId,
      "device_id": deviceId,
      "watering_time": wateringTime,
      "duration": duration,
      "schedule": schedule,
      "frequency": frequency,
      "day_of_month": dayOfMonth,
      "day_of_week": dayOfWeek, 
      "once_on_date": onceOnDate,
      "moisture_threshold": moistureThreshold,
      "active": active,
    };
  }
}
