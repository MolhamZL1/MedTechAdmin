part of 'upload_photo_cubit.dart';

@immutable
sealed class UploadPhotoState {}

final class UploadPhotoInitial extends UploadPhotoState {}

final class UploadPhotoLoading extends UploadPhotoState {}

final class UploadPhotoSuccess extends UploadPhotoState {
  final String? url;

  UploadPhotoSuccess({required this.url});
}

final class UploadPhotoError extends UploadPhotoState {
  final String errMessage;
  UploadPhotoError(this.errMessage);
}
