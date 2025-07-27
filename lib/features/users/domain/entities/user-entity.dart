class GetUserEntity {
  final int id;
  final String email;
  final String username;
  final String role;
  final bool isBanned;
  final DateTime createdAt;

  const GetUserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.isBanned,
    required this.createdAt,
  });

  GetUserEntity copyWith({
    int? id,
    String? email,
    String? username,
    String? role,
    bool? isBanned,
    DateTime? createdAt,
  }) {
    return GetUserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      role: role ?? this.role,
      isBanned: isBanned ?? this.isBanned,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
