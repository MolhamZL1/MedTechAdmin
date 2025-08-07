part of 'add_media_cubit.dart';

@immutable
sealed class AddMediaState {}

final class AddMediaInitial extends AddMediaState {}

final class ImagesUpdated extends AddMediaState {}

final class VideoUpdated extends AddMediaState {}
