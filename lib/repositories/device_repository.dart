import 'package:siram_pintar_mobile/models/add_device_response_model.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';
import 'package:siram_pintar_mobile/models/sensor_data_model.dart';

class DeviceRepository {
  Future<DevicesPlantResponseModel> getDevices(int id) async {
    final response = await apiClient.dio.get(
      '/device',
      queryParameters: {
        'plant_id': id,
      },
    );
    return DevicesPlantResponseModel.fromJson(response.data);
  }

  Future<AddDevicePlantResponseModel> addDevice(
    String name,
    String type,
    int id,
  ) async {
    final response = await apiClient.dio.post(
      '/device',
      data: {
        "plant_id": id,
        "device_name": name,
        "device_type": type,
      },
    );
    return AddDevicePlantResponseModel.fromJson(response.data);
  }

  Future<List<SensorDataModel>> fetchSensorHistory({
    required String deviceId,
    required String filter,
  }) async {
    final response = await apiClient.dio.get(
      '/sensors/sensor-history/$deviceId',
      queryParameters: {
        'filter': filter,
      },
    );

    final List<dynamic> dataList = response.data['data']['data'];
    return dataList.map((json) => SensorDataModel.fromJson(json)).toList();
  }
}
