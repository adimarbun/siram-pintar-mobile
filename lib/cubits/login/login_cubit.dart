import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/auth/auth_cubit.dart';
import 'package:siram_pintar_mobile/cubits/login/login_state.dart';
import 'package:siram_pintar_mobile/repositories/auth_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authRepository,
    required this.authCubit,
  }) : super(const LoginState());

  final AuthRepository authRepository;
  final AuthCubit authCubit;

  void onChangePassword(String? value) {
    emit(state.copyWith(passwordTextField: value));
  }

  void onChangeEmail(String? value) {
    emit(state.copyWith(emailTextField: value));
  }

  void onLogin({
    required VoidCallback onLoading,
    required VoidCallback onSuccess,
    required ValueChanged<dynamic> onFailed,
  }) async {
    try {
      onLoading();
      final response = await authRepository.login(
        state.emailTextField!,
        state.passwordTextField!,
      );
      authCubit.onLoggedIn(response);
      onSuccess();
    } on DioException catch (err) {
      onFailed(err.response?.data['error']);
    } catch (err) {
      onFailed(err);
    }
  }
}
