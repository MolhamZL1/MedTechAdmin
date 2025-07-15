import 'package:med_tech_admin/features/products/domain/entities/vedio_entity.dart';

class VedioModel {
  final String id;
  final String name;
  final String url;
  final String description;
  final String time;

  VedioModel({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.time,
  });

  factory VedioModel.fromJson(Map<String, dynamic> json) {
    return VedioModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      description: json['description'],
      time: json['time'],
    );
  }
  factory VedioModel.fromEntity(VedioEntity entity) => VedioModel(
    id: entity.id,
    name: entity.name,
    url: entity.url,
    description: entity.description,
    time: entity.time,
  );
  tojson() => {
    'id': id,
    'name': name,
    'url': url,
    'description': description,
    'time': time,
  };

  VedioEntity toEntity() => VedioEntity(
    id: id,
    name: name,
    url: url,
    description: description,
    time: time,
  );
}
