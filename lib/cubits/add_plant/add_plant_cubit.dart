import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/add_plant/add_plant_state.dart';
import 'package:siram_pintar_mobile/repositories/plant_repository.dart';

class AddPlantCubit extends Cubit<AddPlantState> {
  AddPlantCubit({
    required this.plantRepository,
  }) : super(const AddPlantState());

  final PlantRepository plantRepository;

  void onChangeName(String? value) {
    emit(state.copyWith(nameTextField: value));
  }

  void onChangeCtrlType(String? value) {
    emit(state.copyWith(ctrlTypeTextField: value));
  }

  void onSave({
    required VoidCallback onLoading,
    required VoidCallback onSuccess,
    required ValueChanged<dynamic> onFailed,
  }) async {
    try {
      onLoading();
      await plantRepository.addPlant(
        state.nameTextField!,
      );
      onSuccess();
    } on DioException catch (err) {
      onFailed(err.response?.data['error']);
    } catch (err) {
      onFailed(err);
    }
  }
}
