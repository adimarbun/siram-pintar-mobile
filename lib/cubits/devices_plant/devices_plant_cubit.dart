import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/devices_plant/devices_plant_state.dart';
import 'package:siram_pintar_mobile/repositories/device_repository.dart';

class DevicesPlantCubit extends Cubit<DevicesPlantState> {
  DevicesPlantCubit({
    required this.deviceRepository,
  }) : super(DevicesPlantLoading());

  final DeviceRepository deviceRepository;

  void getDevices(int id) async {
    try {
      emit(DevicesPlantLoading());
      final response = await deviceRepository.getDevices(id);
      emit(DevicesPlantSLoaded(devicesPlantResponseModel: response));
    } catch (_) {}
  }
}
