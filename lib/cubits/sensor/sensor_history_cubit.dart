import 'package:flutter_bloc/flutter_bloc.dart';
import 'sensor_history_state.dart';
import '../../repositories/device_repository.dart'; 
import '../../models/sensor_data_model.dart'; 

class SensorHistoryCubit extends Cubit<SensorHistoryState> {
  final DeviceRepository deviceRepository;

  SensorHistoryCubit({required this.deviceRepository}) : super(SensorHistoryInitial());

  void getSensorHistory(String deviceId, String filter, String token) async {
    emit(SensorHistoryLoading());
    try {
      final data = await deviceRepository.fetchSensorHistory(deviceId, filter, token);
      emit(SensorHistoryLoaded(data));
    } catch (e) {
      emit(SensorHistoryError(e.toString()));
    }
  }
}
