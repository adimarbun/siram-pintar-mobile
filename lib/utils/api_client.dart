import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/config.dart';
import 'package:siram_pintar_mobile/cubits/auth/auth_cubit.dart';
import 'package:siram_pintar_mobile/utils/navigation.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and handling 401 response
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        // Check for 401 Unauthorized
        if (response.statusCode == 401) {
          _logout();
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        // Handle error response for 401
        if (error.response?.statusCode == 401) {
          _logout();
        }
        return handler.next(error);
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  Dio get dio => _dio;

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeToken() {
    _dio.options.headers.remove('Authorization');
  }

  void _logout() {
    removeToken();

    // Perform any other necessary actions on logout (e.g., navigate to login screen, clear user data)
    // Example: navigate to the login page, or reset the app's state
    Navigation.navigatorKey.currentContext
        ?.read<AuthCubit>()
        .onLoggedOut();
  }
}

final apiClient = ApiClient(baseUrl: baseUrl);
