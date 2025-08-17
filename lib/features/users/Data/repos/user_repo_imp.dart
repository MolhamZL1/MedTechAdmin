import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/features/auth/data/models/user_model.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/entities/entity.dart';
import '../../domain/entities/user-entity.dart';
import '../../domain/repos/user_repo.dart';
import '../models/model.dart';
import '../models/get_user_model.dart';

class UserRepoImp extends UserRepo {
  final DatabaseService databaseService;

  UserRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> banUser(String id) async {
    try {
      await databaseService.updateData(
        endpoint: BackendEndpoints.banUser,
        rowid: id,
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unbanUser(String id) async {
    try {
      await databaseService.updateData(
        endpoint: BackendEndpoints.unbanUser,
        rowid: id,
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createUserByAdmin(CreateUserEntity user) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.createUserByAdmin,
        data: CreateUserModel.fromEntity(user).toJson(),
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await databaseService.deleteData(
        endpoint: BackendEndpoints.deleteUser,
        rowid: id,
      );
      return Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GetUserEntity>>> getUsers() async {
    try {
      var response =
          await databaseService.getData(endpoint: BackendEndpoints.getUsers)
              as List<dynamic>;

      List<GetUserEntity> users =
          response
              .map(
                (e) =>
                    GetUserModel.fromJson(e as Map<String, dynamic>).toEntity(),
              )
              .toList();

      return Right(users);
    } catch (e) {
      log(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
