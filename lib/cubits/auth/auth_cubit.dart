import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:siram_pintar_mobile/cubits/auth/auth_state.dart';
import 'package:siram_pintar_mobile/models/login_response_model.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit({
    required this.apiClient,
  }) : super(AuthLoggedOut());

  final ApiClient apiClient;

  void onLoggedIn(LoginResponseModel loginResponse) {
    apiClient.setToken(loginResponse.token);
    emit(AuthLoggedIn(loginResponse: loginResponse));
  }

  void onLoggedOut() {
    clear();
    apiClient.removeToken();
    emit(AuthLoggedOut());
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      if (json['token'] != null && json['token'] != "") {
        final data = LoginResponseModel.fromJson(json);
        apiClient.setToken(data.token);
        return AuthLoggedIn(loginResponse: data);
      }
    } catch (_) {}
    return AuthLoggedOut();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    try {
      if (state is AuthLoggedIn) {
        return state.loginResponse.toJson();
      }
    } catch (_) {}
    return null;
  }
}
