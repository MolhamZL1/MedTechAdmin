class UserssEntity {
  final String id;
  final String email;
  final String username;
  final String role;
  final String password;

  const UserssEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.password,
  });

  UserssEntity copyWith({
    String? id,
    String? email,
    String? username,
    String? role,
   String ? password
  }) {
    return UserssEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      role: role ?? this.role,
      password:password?? this.password
    );
  }
}
