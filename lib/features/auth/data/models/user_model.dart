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
