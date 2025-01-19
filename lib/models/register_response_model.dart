import 'package:equatable/equatable.dart';

class RegistrationResponseModel extends Equatable {
  const RegistrationResponseModel({
    required this.message,
    required this.user,
  });

  final String message;
  final User user;

  @override
  List<Object> get props => [message, user];

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
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
