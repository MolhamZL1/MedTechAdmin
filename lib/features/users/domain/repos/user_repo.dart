import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entities/entity.dart';
import '../entities/user-entity.dart';

abstract class UserRepo {
  Future<Either<Failure, void>> deleteUser(String id);
  Future<Either<Failure, List<UsersEntity>>> getUsers();
  Future<Either<Failure, void>> banUser(String id);
  Future<Either<Failure, void>> unbanUser(String id);
  Future<Either<Failure, void>> createUserByAdmin(UserssEntity user);
}
