import 'package:equatable/equatable.dart';
import 'package:siram_pintar_mobile/models/login_response_model.dart';

abstract class AuthState extends Equatable {}

class AuthLoggedIn extends AuthState {
  final LoginResponseModel loginResponse;

  AuthLoggedIn({required this.loginResponse});

  @override
  List<Object> get props => [loginResponse];
}

class AuthLoggedOut extends AuthState {
  @override
  List<Object> get props => [];
}
