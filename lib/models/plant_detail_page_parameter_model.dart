import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/plants_response_model.dart';

class PlantDetailPageParameterModel extends Equatable {
  const PlantDetailPageParameterModel({
    required this.plantData,
  });

  final PlantData plantData;

  @override
  List<Object> get props => [plantData];
}
