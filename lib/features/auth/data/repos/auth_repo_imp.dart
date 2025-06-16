import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/core/services/database_service.dart';
import 'package:med_tech_admin/core/utils/backend_endpoints.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';
import 'package:med_tech_admin/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final DatabaseService databaseService;

  AuthRepoImp({required this.databaseService});

  @override
  Future<Either<Failure, UserEntity>> signinUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Map<String, dynamic> data = await databaseService.addData(
      //   endpoint: BackendEndpoints.signIn,
      //   data: {"email": email, "password": password},
      // );
      return right(UserEntity(name: "name", email: email, uid: "uid"));
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
      Map<String, dynamic> data = await databaseService.addData(
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
}
