import 'package:med_tech_admin/features/products/data/models/vedio_model.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/vedio_entity.dart';

class ProductModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String category;
  final String company;
  final String description;
  final num rentStock;
  final num saleStock;
  final num salePrice;
  final num rentalPrice;
  final bool availableForRent;
  final bool availableForSale;
  final String qrCode;
  final List<String> imagesUrl;
  final List<VedioModel> vediomodels;

  ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.category,
    required this.company,
    required this.description,
    required this.rentStock,
    required this.saleStock,
    required this.salePrice,
    required this.rentalPrice,
    required this.availableForRent,
    required this.availableForSale,
    required this.qrCode,
    required this.imagesUrl,
    required this.vediomodels,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    nameEn: json["nameEn"],
    nameAr: json["nameAr"],
    company: json["company"],
    category: json["category"],
    description: json["description"],
    //  rate: json["rate"],
    rentalPrice: json["rentPrice"],
    salePrice: json["sellPrice"],
    availableForRent: json["availableForRent"],
    availableForSale: json["availableForSale"],
    rentStock: json["rentStock"],
    saleStock: json["saleStock"],
    qrCode: json["qrCode"],

    imagesUrl: List<String>.from(json["images"].map((x) => x)),
    vediomodels: List<VedioModel>.from(
      json["videos"].map((x) => VedioModel.fromJson(x)),
    ),
  );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    id: entity.id,
    nameEn: entity.nameEn,
    nameAr: entity.nameAr,
    company: entity.company,
    category: entity.category,
    description: entity.description,
    //  rate: json["rate"],
    rentalPrice: entity.rentalPrice,
    salePrice: entity.salePrice,
    availableForRent: entity.availableForRent,
    availableForSale: entity.availableForSale,
    rentStock: entity.rentStock,
    saleStock: entity.saleStock,
    qrCode: entity.qrCode,
    imagesUrl: entity.imagesUrl,
    vediomodels: List<VedioModel>.from(
      entity.vedioEntities.map((x) => VedioModel.fromEntity(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nameEn": nameEn,
    "nameAr": nameAr,
    "company": company,
    "category": category,
    "description": description,
    "rentPrice": rentalPrice,
    "sellPrice": salePrice,
    "availableForRent": availableForRent,
    "availableForSale": availableForSale,
    "rentStock": rentStock,
    "saleStock": saleStock,
    "qrCode": qrCode,
    "images": List<dynamic>.from(imagesUrl.map((x) => x)),
    "videos": List<dynamic>.from(vediomodels.map((x) => x.tojson())),
  };
  toEntity() => ProductEntity(
    id: id,
    nameEn: nameEn,
    nameAr: nameAr,
    company: company,
    category: category,
    description: description,
    //  rate: json["rate"],
    rentalPrice: rentalPrice,
    salePrice: salePrice,
    availableForRent: availableForRent,
    availableForSale: availableForSale,
    rentStock: rentStock,
    saleStock: saleStock,
    qrCode: qrCode,
    imagesUrl: imagesUrl,
    vedioEntities: List<VedioEntity>.from(vediomodels.map((x) => x.toEntity())),
  );
}
