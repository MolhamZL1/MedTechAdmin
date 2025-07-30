class CreateUserEntity {
  final String id;
  final String email;
  final String username;
  final String role;
  final String password;

  const CreateUserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.password,
  });

  CreateUserEntity copyWith({
    String? id,
    String? email,
    String? username,
    String? role,
   String ? password
  }) {
    return CreateUserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      role: role ?? this.role,
      password:password?? this.password
    );
  }
}
