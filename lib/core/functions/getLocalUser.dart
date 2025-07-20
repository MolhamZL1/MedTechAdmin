import 'dart:convert';

import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';

import '../../features/auth/data/models/user_model.dart';
import '../services/local_storage_service.dart';

Future<UserEntity?> getLocalUser() async {
  final jsonString = await LocalStorageService.getItem(LocalStorageKeys.user);
  UserEntity? user =
      jsonString == null
          ? null
          : UserModel.fromJson(jsonDecode(jsonString)).toEntity();
  return user;
}
