import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';

abstract class DevicesPlantState extends Equatable {}

class DevicesPlantSLoaded extends DevicesPlantState {
  final DevicesPlantResponseModel devicesPlantResponseModel;

  DevicesPlantSLoaded({required this.devicesPlantResponseModel});

  @override
  List<Object> get props => [devicesPlantResponseModel];
}

class DevicesPlantLoading extends DevicesPlantState {
  @override
  List<Object> get props => [];
}
