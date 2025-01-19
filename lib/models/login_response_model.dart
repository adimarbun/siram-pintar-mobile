import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  const LoginResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  final String message;
  final String token;
  final User user;

  @override
  List<Object> get props => [message, token, user];

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,
  });

  final int id;
  final String email;
  final String name;

  @override
  List<Object> get props => [id, email, name];


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
