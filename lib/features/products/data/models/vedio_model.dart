import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/products/domain/entities/vedio_entity.dart';

class VedioModel {
  final num id;
  final String name;
  final String url;
  final String description;

  VedioModel({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
  });

  factory VedioModel.fromJson(Map<String, dynamic> json) {
    return VedioModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      description: json['bio'] ?? "",
    );
  }
  factory VedioModel.fromEntity(VedioEntity entity) => VedioModel(
    id: entity.id,
    name: entity.name,
    url: entity.url,
    description: entity.description,
  );
  tojson() => {'id': id, 'name': name, 'url': url, 'bio': description};

  VedioEntity toEntity() => VedioEntity(
    id: id,
    name: name,
    url: "${BackendEndpoints.url}$url",
    description: description,
  );
}
