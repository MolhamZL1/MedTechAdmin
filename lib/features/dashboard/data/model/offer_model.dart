
// دالة مساعدة لتحويل الأرقام بأمان
import '../../domain/entities/offer_entity.dart';

double _parseDouble(dynamic value) => (value as num?)?.toDouble() ?? 0.0;

class AdvertisementModel extends AdvertisementEntity {
  const AdvertisementModel({
    required super.id,
    required super.title,
    required super.bio,
    required super.imageUrl,
    super.linkUrl,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
      id: json['id'] as int,
      title: json['title'] as String,
      bio: json['bio'] as String,
      imageUrl: json['imageUrl'] as String,
      linkUrl: json['linkUrl'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
