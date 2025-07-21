import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/features/auth/data/models/user_model.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../domain/repos/user_repo.dart';

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
  Future<Either<Failure, void>> createUserByAdmin(UserEntity user) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.createUserByAdmin,
        data: UserModel.fromEntity(user).toJson(),
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
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final users = await databaseService.getData(
        endpoint: BackendEndpoints.getUsers,
      );
      return Right(users.map((e) => UserModel.fromJson(e).toEntity()).toList());
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
