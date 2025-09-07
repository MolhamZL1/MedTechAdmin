import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:med_tech_admin/core/functions/pick_image_from_device.dart';
import 'package:meta/meta.dart';

part 'add_media_state.dart';

class AddMediaCubit extends Cubit<AddMediaState> {
  AddMediaCubit() : super(AddMediaInitial());
  List<Uint8List> imageFiles = [];
  List<Uint8List> videoFiles = [];

  void addImage() {
    pickImage(
      onPhotoSelected: (value) {
        imageFiles.add(value);
        emit(ImagesUpdated());
      },
    );
  }

  void removeImage(int index) {
    imageFiles.removeAt(index);
    emit(ImagesUpdated());
  }

  void addVideo() {
    pickImage(
      isVideo: true,
      onPhotoSelected: (value) {
        videoFiles.add(value);
        emit(VideoUpdated());
      },
    );
  }

  void removeVideo(int index) {
    videoFiles.removeAt(index);
    emit(VideoUpdated());
  }
  void clearMedia() {
    imageFiles.clear(); // مسح قائمة الصور
    videoFiles.clear(); // مسح قائمة الفيديوهات
    emit(AddMediaInitial()); // إصدار حالة جديدة لإعادة بناء الواجهة إذا لزم الأمر
  }
}
