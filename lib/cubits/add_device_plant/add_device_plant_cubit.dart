import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/add_device_plant/add_device_plant_state.dart';
import 'package:siram_pintar_mobile/repositories/device_repository.dart';

class AddDevicePlantCubit extends Cubit<AddDevicePlantState> {
  AddDevicePlantCubit({
    required this.deviceRepository,
  }) : super(const AddDevicePlantState());

  final DeviceRepository deviceRepository;

  void onChangeName(String? value) {
    emit(state.copyWith(nameTextField: value));
  }

  void onChangeCtrlType(String? value) {
    emit(state.copyWith(ctrlTypeTextField: value));
  }

  void onSave(
    int id, {
    required VoidCallback onLoading,
    required VoidCallback onSuccess,
    required ValueChanged<dynamic> onFailed,
  }) async {
    try {
      onLoading();
      await deviceRepository.addDevice(
        state.nameTextField!,
        state.ctrlTypeTextField!,
        id,
      );
      onSuccess();
    } on DioException catch (err) {
      onFailed(err.response?.data['error']);
    } catch (err) {
      onFailed(err);
    }
  }
}
