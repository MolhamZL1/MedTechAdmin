import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';
import 'package:meta/meta.dart';

part 'upload_photo_state.dart';

class UploadPhotoCubit extends Cubit<UploadPhotoState> {
  UploadPhotoCubit(this.settingsRepo) : super(UploadPhotoInitial());
  final SettingsRepo settingsRepo;

  Future<void> uploadPhoto({required Uint8List photo}) async {
    emit(UploadPhotoLoading());
    final result = await settingsRepo.uploadPhoto(photo: photo);
    result.fold(
      (l) => emit(UploadPhotoError(l.errMessage)),
      (r) => emit(UploadPhotoSuccess()),
    );
  }
}
