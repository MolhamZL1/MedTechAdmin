import 'package:med_tech_admin/features/products/data/models/vedio_model.dart';

import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;

  final String image;
  final String category;
  final String status;
  final int stock;
  final num salePrice;
  final num rentalPrice;
  final List<VedioModel> vedioModels;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.status,
    required this.stock,
    required this.salePrice,
    required this.rentalPrice,
    required this.vedioModels,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    category: json["category"],
    status: json["status"],
    stock: json["stock"],
    salePrice: json["salePrice"],
    rentalPrice: json["rentalPrice"],
    vedioModels: List<VedioModel>.from(
      json["vedioModels"].map((x) => VedioModel.fromJson(x)),
    ),
  );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    image: entity.imageUrl,
    category: entity.category,
    status: entity.status,
    stock: entity.stock,
    salePrice: entity.salePrice,
    rentalPrice: entity.rentalPrice,
    vedioModels:
        entity.vedioEntities.map((e) => VedioModel.fromEntity(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "category": category,
    "status": status,
    "stock": stock,
    "salePrice": salePrice,
    "rentalPrice": rentalPrice,
    "vedioModels": List<dynamic>.from(vedioModels.map((x) => x.tojson())),
  };
}
