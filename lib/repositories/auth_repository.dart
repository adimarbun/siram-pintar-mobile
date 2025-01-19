import 'package:siram_pintar_mobile/models/login_response_model.dart';
import 'package:siram_pintar_mobile/models/register_response_model.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';

class AuthRepository {
  Future<LoginResponseModel> login(
    String email,
    String password,
  ) async {
    final response = await apiClient.dio.post(
      '/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );
    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegistrationResponseModel> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await apiClient.dio.post(
      '/auth/register',
      data: {
        "email": email,
        "name": name,
        "password": password,
      },
    );
    return RegistrationResponseModel.fromJson(response.data);
  }
}
