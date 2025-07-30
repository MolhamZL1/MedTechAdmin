import '../../domain/entities/entity.dart';
import '../../domain/entities/user-entity.dart';

class CreateUserModel {
  final String id;
  final String email;
  final String username;
  final String role;
  final String password;

  CreateUserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.password
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) {
    return CreateUserModel(
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

  CreateUserEntity toEntity() {
    return CreateUserEntity(
      id: id,
      email: email,
      username: username,
      role: role,
      password: password,

    );
  }

  factory CreateUserModel.fromEntity(CreateUserEntity entity) {
    return CreateUserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      role: entity.role,
      password: entity.password,

    );
  }
}