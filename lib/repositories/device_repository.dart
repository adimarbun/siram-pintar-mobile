import 'package:siram_pintar_mobile/models/add_device_response_model.dart';
import 'package:siram_pintar_mobile/models/devices_plant_response_model.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';

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
}
