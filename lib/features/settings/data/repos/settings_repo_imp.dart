import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';

class SettingsRepoImp extends SettingsRepo {
  final DatabaseService databaseService;

  SettingsRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.changePassword,
        data: {"currentPassword": currentPassword, "newPassword": newPassword},
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> uploadPhoto({
    required Uint8List photo,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.uploadProfilePhoto,
        data: {"photo": photo},
      );
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
