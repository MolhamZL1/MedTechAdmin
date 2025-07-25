import '../../domain/entities/entity.dart';
import '../../domain/entities/user-entity.dart';

class UserssModel {
  final String id;
  final String email;
  final String username;
  final String role;
  final String password;

  UserssModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.password
  });

  factory UserssModel.fromJson(Map<String, dynamic> json) {
    return UserssModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'role': role,
      'password': password,

    };
  }

  UserssEntity toEntity() {
    return UserssEntity(
      id: id,
      email: email,
      username: username,
      role: role,
      password: password,

    );
  }

  factory UserssModel.fromEntity(UserssEntity entity) {
    return UserssModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      role: entity.role,
      password: entity.password,

    );
  }
}