import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/plants/plants_state.dart';
import 'package:siram_pintar_mobile/repositories/plant_repository.dart';

class PlantsCubit extends Cubit<PlantsState> {
  PlantsCubit({
    required this.plantRepository,
  }) : super(PlantsLoading());

  final PlantRepository plantRepository;

  void getPlants() async {
    try {
      final response = await plantRepository.getPlants();
      emit(PlantsLoaded(plantResponse: response));
    } catch (_) {}
  }
}
