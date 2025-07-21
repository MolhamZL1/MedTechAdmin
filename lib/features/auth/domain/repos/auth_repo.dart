import 'package:dartz/dartz.dart';
import 'package:med_tech_admin/core/errors/failures.dart';
import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> signinUsingEmailAndPassword({
    required String email,
    required String password,
  }); ////
  Future<Either<Failure, dynamic>> forgetPassword({
    required String email,
  }); //send code
  Future<Either<Failure, dynamic>> resetpassword({
    required String email,
    required String code,
    required String newpassword,
  });
  ////

  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity>> signinUsingGoogle();
}
