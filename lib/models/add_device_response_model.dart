import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';

class AddDevicePlantResponseModel extends Equatable {
  final String status;
  final String message;
  final DeviceData data;

  const AddDevicePlantResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, message, data];

  factory AddDevicePlantResponseModel.fromJson(Map<String, dynamic> json) {
    return AddDevicePlantResponseModel(
      status: json['status'],
      message: json['message'],
      data: DeviceData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}
