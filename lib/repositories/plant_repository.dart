import 'package:siram_pintar_mobile/models/add_plant_response_model.dart';
import 'package:siram_pintar_mobile/models/plants_response_model.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';

class PlantRepository {
  Future<PlantsResponseModel> getPlants() async {
    final response = await apiClient.dio.get('/plant');
    return PlantsResponseModel.fromJson(response.data);
  }

  Future<AddPlantResponseModel> addPlant(String name) async {
    final response = await apiClient.dio.post('/plant', data: {
      "plant_name": name,
    });
    return AddPlantResponseModel.fromJson(response.data);
  }
}
