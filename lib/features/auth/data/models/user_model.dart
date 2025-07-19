import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';

class UserModel {
  final String name;
  final String email;
  final String role;

  final String token;
  const UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['username'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }
  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      name: userEntity.name,
      email: userEntity.email,
      role: userEntity.role,
      token: userEntity.token,
    );
  }

  toJson() => {"username": name, "email": email, "role": role, "token": token};
  toEntity() => UserEntity(name: name, email: email, role: role, token: token);
}

class UserPrefs {
  static Future<void> saveUser(UserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'userData',
      UserModel.fromEntity(user).toJson().toString(),
    );
  }

  static Future<UserEntity?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('userData');
    if (raw == null) return null;
    final json = Map<String, dynamic>.from(jsonDecode(raw));
    return UserModel.fromJson(json).toEntity();
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
  }
}
