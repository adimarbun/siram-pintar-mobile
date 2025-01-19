import 'package:equatable/equatable.dart';

class PlantsResponseModel extends Equatable {
  final String status;
  final String message;
  final List<PlantData> data;

  const PlantsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PlantsResponseModel.fromJson(Map<String, dynamic> json) {
    return PlantsResponseModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => PlantData.fromJson(item))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}

class PlantData extends Equatable {
  final int id;
  final int userId;
  final String plantName;
  final DateTime createdAt;

  const PlantData({
    required this.id,
    required this.userId,
    required this.plantName,
    required this.createdAt,
  });

  factory PlantData.fromJson(Map<String, dynamic> json) {
    return PlantData(
      id: json['id'],
      userId: json['user_id'],
      plantName: json['plant_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  List<Object?> get props => [id, userId, plantName, createdAt];
}
