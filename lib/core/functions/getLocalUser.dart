import 'dart:convert';

import 'package:med_tech_admin/features/auth/domain/entities/user_entity.dart';

import '../../features/auth/data/models/user_model.dart';
import '../services/local_storage_service.dart';

class UserService {
  UserEntity? _cachedUser;

  Future<void> loadUser() async {
    final jsonString = await LocalStorageService.getItem(LocalStorageKeys.user);
    if (jsonString != null) {
      _cachedUser = UserModel.fromJson(jsonDecode(jsonString)).toEntity();
    } else {
      _cachedUser = null;
    }
  }

  UserEntity? get user => _cachedUser;
}
