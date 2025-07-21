import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/core/services/local_storage_service.dart';
import 'package:med_tech_admin/features/auth/data/models/user_model.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../core/functions/getLocalUser.dart';
import '../../../../auth/domain/entities/user_entity.dart';

part 'upload_photo_state.dart';

class UploadPhotoCubit extends Cubit<UploadPhotoState> {
  UploadPhotoCubit(this.settingsRepo) : super(UploadPhotoInitial());
  final SettingsRepo settingsRepo;

  Future<void> uploadPhoto({required Uint8List photo}) async {
    emit(UploadPhotoLoading());
    final result = await settingsRepo.uploadPhoto(photo: photo);
    result.fold((l) => emit(UploadPhotoError(l.errMessage)), (photo) async {
      String url = photo;
      UserEntity? user = await getLocalUser();
      user = user!.copyWith(photo: url);
      await LocalStorageService.setItem(
        LocalStorageKeys.user,
        jsonEncode(UserModel.fromEntity(user).toJson()),
      );
      emit(UploadPhotoSuccess(url: photo));
    });
  }

  Future<void> deletePhoto() async {
    emit(UploadPhotoLoading());
    final result = await settingsRepo.deletePhoto();
    result.fold((l) => emit(UploadPhotoError(l.errMessage)), (r) async {
      UserEntity? user = await getLocalUser();
      user = user!.copyWith(photo: null);
      await LocalStorageService.setItem(
        LocalStorageKeys.user,
        jsonEncode(UserModel.fromEntity(user).toJson()),
      );
      emit(UploadPhotoSuccess(url: null));
    });
  }
}
