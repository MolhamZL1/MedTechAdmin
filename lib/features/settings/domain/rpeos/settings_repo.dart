import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class SettingsRepo {
  Future<Either<Failure, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Either<Failure, String>> uploadPhoto({required Uint8List photo});

  Future<Either<Failure, void>> deletePhoto();
}
