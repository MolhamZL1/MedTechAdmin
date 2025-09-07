import 'dart:typed_data';
import 'package:dio/dio.dart';

class ProductEditeModel {
  final String nameEn;
  final String nameAr;
  final String categoryEn;
  final String? categoryAr;
  final String companyEn;
  final String? companyAr;
  final String descriptionEn;
  final String? descriptionAr;
  final num? rentStock;      // ✨ تأكد من أنها nullable (num?)
  final num? saleStock;      // ✨ تأكد من أنها nullable (num?)
  final num? salePrice;      // ✨ تأكد من أنها nullable (num?)
  final num? rentalPrice;    // ✨ تأكد من أنها nullable (num?)
  final bool availableForRent;
  final bool availableForSale;
  //final num? costPrice;      // ✨ تأكد من أنها nullable (num?)
  final List<Uint8List> images;
  final List<Uint8List> videos;

  ProductEditeModel({
    required this.nameEn,
    required this.nameAr,
    required this.categoryEn,
    this.categoryAr,
    required this.companyEn,
    this.companyAr,
    required this.descriptionEn,
    this.descriptionAr,
    this.rentStock,      // ✨ اجعلها اختيارية
    this.saleStock,      // ✨ اجعلها اختيارية
    this.salePrice,      // ✨ اجعلها اختيارية
    this.rentalPrice,    // ✨ اجعلها اختيارية
    //this.costPrice,      // ✨ اجعلها اختيارية
    required this.availableForRent,
    required this.availableForSale,
    required this.images,
    required this.videos,
  });

  Future<FormData> toFormData({bool isEdit = false}) async {
    final Map<String, dynamic> map = {
      "availableForRent": availableForRent,
      "availableForSale": availableForSale,
    };

    // إضافة الحقول النصية فقط إذا لم تكن فارغة
    if (nameEn.isNotEmpty) map["nameEn"] = nameEn;
    if (nameAr.isNotEmpty) map["nameAr"] = nameAr;
    // ... (بقية الحقول النصية)

    // ✨✨ الحل هنا: التحقق من أن القيمة ليست null قبل إضافتها إلى الـ Map ✨✨
    if (rentalPrice != null) map["rentPrice"] = rentalPrice;
    if (salePrice != null) map["sellPrice"] = salePrice;
    if (rentStock != null) map["rentStock"] = rentStock;
    if (saleStock != null) map["saleStock"] = saleStock;
   // if (costPrice != null) map["costPrice"] = costPrice;

    final formData = FormData.fromMap(map);

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
