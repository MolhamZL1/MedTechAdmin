import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:med_tech_admin/core/errors/failures.dart';

import '../entities/offer_entity.dart';

abstract class AdvertisementRepo {
  // دالة لجلب قائمة الإعلانات
  Future<Either<Failure, List<AdvertisementEntity>>> getAdvertisements();

  // دالة لإنشاء إعلان جديد
  Future<Either<Failure, AdvertisementEntity>> createAdvertisement({
    required String title,
    required String bio,
    required Uint8List imageBytes,
    required String imageName,
  });
}
