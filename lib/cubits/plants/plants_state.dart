import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/login_response_model.dart';
import 'package:siram_pintar_mobile/models/plants_response_model.dart';

abstract class PlantsState extends Equatable {}

class PlantsLoaded extends PlantsState {
  final PlantsResponseModel plantResponse;

  PlantsLoaded({required this.plantResponse});

  @override
  List<Object> get props => [plantResponse];
}

class PlantsLoading extends PlantsState {

  @override
  List<Object> get props => [];
}
