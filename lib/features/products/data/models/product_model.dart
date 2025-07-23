import 'package:med_tech_admin/features/products/data/models/vedio_model.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/vedio_entity.dart';

class ProductModel {
  final num id;
  final String nameEn;
  final String nameAr;
  final String categoryEn;
  final String categoryAr;
  final String companyEn;
  final String companyAr;
  final String descriptionEn;
  final String descriptionAr;
  final num rentStock;
  final num saleStock;
  final num salePrice;
  final num rentalPrice;
  final bool availableForRent;
  final bool availableForSale;
  final String qrCode;
  final List<String> imagesUrl;
  final num rate;
  final List<String> videos;

  ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.categoryEn,
    required this.categoryAr,
    required this.companyEn,
    required this.companyAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.rentStock,
    required this.saleStock,
    required this.salePrice,
    required this.rentalPrice,
    required this.availableForRent,
    required this.availableForSale,
    required this.qrCode,
    required this.imagesUrl,
    required this.rate,
    required this.videos,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    nameEn: json["nameEn"],
    nameAr: json["nameAr"],
    categoryEn: json["categoryEn"],
    categoryAr: json["categoryAr"],
    companyEn: json["companyEn"],
    companyAr: json["companyAr"],
    descriptionEn: json["descriptionEn"],
    descriptionAr: json["descriptionAr"],
    rate: json["rate"],
    rentalPrice: json["rentPrice"],
    salePrice: json["sellPrice"],
    availableForRent: json["availableForRent"],
    availableForSale: json["availableForSale"],
    rentStock: json["rentStock"],
    saleStock: json["saleStock"],
    qrCode: json["qrCode"],

    imagesUrl: List<String>.from(json["images"].map((x) => x)),
    videos: List<String>.from(json["videos"].map((x) => x)),
  );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    id: entity.id,
    nameEn: entity.nameEn,
    nameAr: entity.nameAr,
    categoryEn: entity.categoryEn,
    categoryAr: entity.categoryAr,
    companyEn: entity.companyEn,
    companyAr: entity.companyAr,
    descriptionEn: entity.descriptionEn,
    descriptionAr: entity.descriptionAr,
    rate: entity.rate,
    rentalPrice: entity.rentalPrice,
    salePrice: entity.salePrice,
    availableForRent: entity.availableForRent,
    availableForSale: entity.availableForSale,
    rentStock: entity.rentStock,
    saleStock: entity.saleStock,
    qrCode: entity.qrCode,
    imagesUrl: entity.imagesUrl,
    videos: List<String>.from(entity.vedioUrls.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nameEn": nameEn,
    "nameAr": nameAr,
    "categoryEn": categoryEn,
    "categoryAr": categoryAr,
    "companyEn": companyEn,
    "companyAr": companyAr,
    "descriptionEn": descriptionEn,
    "descriptionAr": descriptionAr,
    "rate": rate,
    "rentPrice": rentalPrice,
    "sellPrice": salePrice,
    "availableForRent": availableForRent,
    "availableForSale": availableForSale,
    "rentStock": rentStock,
    "saleStock": saleStock,
    "qrCode": qrCode,
    "images": List<dynamic>.from(imagesUrl.map((x) => x)),
    "videos": List<dynamic>.from(videos.map((x) => x)),
  };
  toEntity() => ProductEntity(
    id: id,
    nameEn: nameEn,
    nameAr: nameAr,
    categoryEn: categoryEn,
    categoryAr: categoryAr,
    companyEn: companyEn,
    companyAr: companyAr,
    descriptionEn: descriptionEn,
    descriptionAr: descriptionAr,
    rate: rate,
    rentalPrice: rentalPrice,
    salePrice: salePrice,
    availableForRent: availableForRent,
    availableForSale: availableForSale,
    rentStock: rentStock,
    saleStock: saleStock,
    qrCode: qrCode,
    imagesUrl: imagesUrl,
    vedioUrls: videos,
  );
}
