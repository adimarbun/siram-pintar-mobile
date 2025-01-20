import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/plants_response_model.dart';

class AddDevicePageParameterModel extends Equatable {
  const AddDevicePageParameterModel({
    required this.plantData,
  });

  final PlantData plantData;

  @override
  List<Object> get props => [plantData];
}
