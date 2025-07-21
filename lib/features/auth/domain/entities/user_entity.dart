class UserEntity {
  final String name;
  final String email;
  final String token;
  final String role;
  final String? photo;
  final String? phoneNumber;

  const UserEntity({
    required this.name,
    required this.email,
    required this.token,
    this.phoneNumber,
    this.photo,
    required this.role,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? token,
    String? role,
    String? photo,
    String? phoneNumber,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      role: role ?? this.role,
      photo: photo ?? this.photo,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
