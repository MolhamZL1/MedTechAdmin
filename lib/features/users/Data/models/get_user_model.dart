import '../../domain/entities/user-entity.dart';

class GetUserModel {
  final int id;
  final String email;
  final String username;
  final String role;
  final bool isBanned;
  final DateTime createdAt;

  GetUserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.isBanned,
    required this.createdAt,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
      isBanned: json['isBanned'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'role': role,
      'isBanned': isBanned,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  GetUserEntity toEntity() {
    return GetUserEntity(
      id: id,
      email: email,
      username: username,
      role: role,
      isBanned: isBanned,
      createdAt: createdAt,
    );
  }

  factory GetUserModel.fromEntity(GetUserEntity entity) {
    return GetUserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      role: entity.role,
      isBanned: entity.isBanned,
      createdAt: entity.createdAt,
    );
  }
}
