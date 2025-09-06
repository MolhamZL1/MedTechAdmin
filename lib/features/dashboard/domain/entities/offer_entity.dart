class AdvertisementEntity {
  final int id;
  final String title;
  final String bio;
  final String imageUrl;
  final String? linkUrl; // قد يكون null
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdvertisementEntity({
    required this.id,
    required this.title,
    required this.bio,
    required this.imageUrl,
    this.linkUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}
