import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.nameTextField,
    this.emailTextField,
    this.passwordTextField,
  });

  final String? nameTextField;
  final String? emailTextField;
  final String? passwordTextField;

  @override
  List<Object?> get props => [
        nameTextField,
        emailTextField,
        passwordTextField,
      ];

  RegisterState copyWith({
    String? nameTextField,
    String? emailTextField,
    String? passwordTextField,
  }) {
    return RegisterState(
      nameTextField: nameTextField ?? this.nameTextField,
      emailTextField: emailTextField ?? this.emailTextField,
      passwordTextField: passwordTextField ?? this.passwordTextField,
    );
  }
}
