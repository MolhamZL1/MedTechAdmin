import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';
import 'package:med_tech_admin/features/auth/domain/repos/auth_repo.dart';

import '../models/user_model.dart';

class AuthRepoImp implements AuthRepo {
  final DatabaseService databaseService;

  AuthRepoImp({required this.databaseService});

  @override
  Future<Either<Failure, UserEntity>> signinUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await databaseService.addData(
        endpoint: BackendEndpoints.signIn,
        data: {"identifier": email, "password": password},
      );

      return right(UserModel.fromJson(response.data).toEntity());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinUsingGoogle() {
    // TODO: implement signinUsingGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.signIn,
        data: {},
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
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.forgetPassword,
        data: {"email": email},
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
  Future<Either<Failure, void>> resetpassword({
    required String email,
    required String code,
    required String newpassword,
  }) async {
    try {
      await databaseService.addData(
        endpoint: BackendEndpoints.resetPassword,
        data: {"email": email, "code": code, "newPassword": newpassword},
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
