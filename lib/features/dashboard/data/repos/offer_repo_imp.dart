import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';

import '../../domain/entities/offer_entity.dart';
import '../../domain/repos/offer_repo.dart';
import '../model/offer_model.dart';


class AdvertisementRepoImpl implements AdvertisementRepo {
  final DatabaseService databaseService;
  AdvertisementRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<AdvertisementEntity>>> getAdvertisements() async {
    try {
      final response = await databaseService.getData(
        endpoint: BackendEndpoints.listAdvertisements,
      );
      if (response is! List) {
        return Left(ServerFailure(errMessage: "Expected a list of advertisements"));
      }
      final ads = response.map((e) => AdvertisementModel.fromJson(e)).toList();
      return Right(ads);
    } catch (e) {
      if (e is DioException) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AdvertisementEntity>> createAdvertisement({
    required String title,
    required String bio,
    required Uint8List imageBytes,
    required String imageName,
  }) async {
    try {
      // إنشاء FormData لإرسال الملفات والنصوص معًا
      final formData = FormData.fromMap({
        'title': title,
        'bio': bio,
        'image': MultipartFile.fromBytes(
          imageBytes,
          filename: imageName, // اسم الملف مهم للـ backend
        ),
      });

      final response = await databaseService.addData(
        endpoint: BackendEndpoints.createAdvertisement,
        data: formData,
      );

      // الـ response يحتوي على "message" و "advertisement"
      final adJson = response['advertisement'] as Map<String, dynamic>;
      final newAd = AdvertisementModel.fromJson(adJson);
      return Right(newAd);

    } catch (e) {
      if (e is DioException) return Left(ServerFailure.fromDioError(e));
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
