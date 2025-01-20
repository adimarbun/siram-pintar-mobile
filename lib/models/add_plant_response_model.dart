import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/plants_response_model.dart';

class AddPlantResponseModel extends Equatable {
  final String status;
  final String message;
  final PlantData data;

  const AddPlantResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddPlantResponseModel.fromJson(Map<String, dynamic> json) {
    return AddPlantResponseModel(
      status: json['status'],
      message: json['message'],
      data: PlantData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [status, message, data];
}
