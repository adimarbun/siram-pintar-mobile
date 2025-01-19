import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.emailTextField,
    this.passwordTextField,
  });

  final String? emailTextField;
  final String? passwordTextField;

  @override
  List<Object?> get props => [
        emailTextField,
        passwordTextField,
      ];

  LoginState copyWith({
    String? emailTextField,
    String? passwordTextField,
  }) {
    return LoginState(
      emailTextField: emailTextField ?? this.emailTextField,
      passwordTextField: passwordTextField ?? this.passwordTextField,
    );
  }
}
