import 'package:equatable/equatable.dart';

class DevicesPlantResponseModel extends Equatable {
  final String status;
  final String message;
  final List<DeviceData> data;

  const DevicesPlantResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DevicesPlantResponseModel.fromJson(Map<String, dynamic> json) {
    return DevicesPlantResponseModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((deviceJson) => DeviceData.fromJson(deviceJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((device) => device.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, message, data];
}

class DeviceData extends Equatable {
  final int id;
  final int plantId;
  final String deviceName;
  final String deviceType;
  final String createdAt;

  const DeviceData({
    required this.id,
    required this.plantId,
    required this.deviceName,
    required this.deviceType,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, plantId, deviceName, deviceType, createdAt];

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      id: json['id'],
      plantId: json['plant_id'],
      deviceName: json['device_name'],
      deviceType: json['device_type'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant_id': plantId,
      'device_name': deviceName,
      'device_type': deviceType,
      'created_at': createdAt,
    };
  }
}
