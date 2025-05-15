import 'package:siram_pintar_mobile/models/schedule_request_model.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';

class ScheduleRepository {
  Future<bool> createSchedule(ScheduleRequestModel request) async {
    try {
      await apiClient.dio.post(
        '/schedule',
        data: request.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getSchedulesByDeviceId(int deviceId) async {
    try {
      final response = await apiClient.dio.get('/schedule/device/$deviceId');
      final List<dynamic> data = response.data['data'];
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Gagal mengambil jadwal: $e');
    }
  }

  Future<bool> updateSchedule(int id, ScheduleRequestModel request) async {
    try {
      await apiClient.dio.put(
        '/schedule/$id',
        data: request.toJson(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSchedule(int id) async {
    try {
      await apiClient.dio.delete('/schedule/$id');
      return true;
    } catch (e) {
      return false;
    }
  }
}
