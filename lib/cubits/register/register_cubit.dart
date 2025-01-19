import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siram_pintar_mobile/cubits/register/register_state.dart';
import 'package:siram_pintar_mobile/repositories/auth_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.authRepository,
  }) : super(const RegisterState());

  final AuthRepository authRepository;

  void onChangeName(String? value) {
    emit(state.copyWith(nameTextField: value));
  }

  void onChangePassword(String? value) {
    emit(state.copyWith(passwordTextField: value));
  }

  void onChangeEmail(String? value) {
    emit(state.copyWith(emailTextField: value));
  }

  void onRegister({
    required VoidCallback onLoading,
    required VoidCallback onSuccess,
    required ValueChanged<dynamic> onFailed,
  }) async {
    try {
      onLoading();
      await authRepository.register(
        state.nameTextField!,
        state.emailTextField!,
        state.passwordTextField!,
      );
      onSuccess();
    } on DioException catch (err) {
      onFailed(err.response?.data['error']);
    } catch (err) {
      onFailed(err);
    }
  }
}
