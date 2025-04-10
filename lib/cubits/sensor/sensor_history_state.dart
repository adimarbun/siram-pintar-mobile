import 'package:equatable/equatable.dart';
import 'sensor_data_model.dart'; 

abstract class SensorHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SensorHistoryInitial extends SensorHistoryState {}

class SensorHistoryLoading extends SensorHistoryState {}

class SensorHistoryLoaded extends SensorHistoryState {
  final List<SensorDataModel> sensorData;

  SensorHistoryLoaded(this.sensorData);

  @override
  List<Object?> get props => [sensorData];
}

class SensorHistoryError extends SensorHistoryState {
  final String message;

  SensorHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
