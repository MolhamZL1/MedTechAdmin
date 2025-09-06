import 'dart:typed_data';

import 'package:dio/dio.dart';

class ProductUploadModel {
  final String nameEn;
  final String nameAr;
  final String categoryEn;
  final String? categoryAr;
  final String companyEn;
  final String? companyAr;
  final String descriptionEn;
  final String? descriptionAr;
  final num rentStock;
  final num saleStock;
  final num salePrice;
  final num rentalPrice;
  final bool availableForRent;
  final bool availableForSale;
  final num costPrice;
  final List<Uint8List> images;
  final List<Uint8List> videos;
  ProductUploadModel({
    required this.nameEn,
    required this.nameAr,
    required this.categoryEn,
    this.categoryAr,
    required this.companyEn,
    this.companyAr,
    required this.descriptionEn,
    this.descriptionAr,
    required this.rentStock,
    required this.saleStock,
    required this.salePrice,
    required this.rentalPrice,
    required this.costPrice,
    required this.availableForRent,
    required this.availableForSale,
    required this.images,
    required this.videos,
  });
  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      "nameEn": nameEn,
      "nameAr": nameAr,
      "category": categoryEn,
      "categoryAr": categoryAr,
      "company": companyEn,
      "companyAr": companyAr,
      "description": descriptionEn,
      "descriptionAr": descriptionAr,
      "rentPrice": rentalPrice,
      "sellPrice": salePrice,
      "availableForRent": availableForRent,
      "availableForSale": availableForSale,
      "rentStock": rentStock,
      "saleStock": saleStock,
      "costPrice":costPrice,
    });

    for (int i = 0; i < images.length; i++) {
      formData.files.add(
        MapEntry(
          "images",
          MultipartFile.fromBytes(images[i], filename: "image_$i.jpg"),
        ),
      );
    }

    for (int i = 0; i < videos.length; i++) {
      formData.files.add(
        MapEntry(
          "videos",
          MultipartFile.fromBytes(videos[i], filename: "video_$i.mp4"),
        ),
      );
    }

    return formData;
  }
}
