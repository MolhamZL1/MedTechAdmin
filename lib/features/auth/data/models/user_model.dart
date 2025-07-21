import '../../domain/entities/user_entity.dart';

class UserModel {
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  final String? photo;

  final String token;
  const UserModel({
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.photo,
    required this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['username'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      photo: json['photo'],
      token: json['token'],
    );
  }
  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      name: userEntity.name,
      email: userEntity.email,
      role: userEntity.role,
      phoneNumber: userEntity.phoneNumber,
      photo: userEntity.photo,
      token: userEntity.token,
    );
  }

  toJson() => {
    "username": name,
    "email": email,
    "role": role,
    "phoneNumber": phoneNumber,
    "photo": photo,
  };
  toEntity() => UserEntity(
    name: name,
    email: email,
    role: role,
    phoneNumber: phoneNumber,
    photo: photo,
    token: token,
  );
}
