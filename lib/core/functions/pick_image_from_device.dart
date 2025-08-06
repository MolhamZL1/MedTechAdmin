import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage({
  required ValueChanged<dynamic> onPhotoSelected,
  bool isVideo = false,
}) async {
  XFile? image;
  if (isVideo) {
    image = await ImagePicker().pickVideo(source: ImageSource.gallery);
  } else {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }
  if (image != null) {
    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      onPhotoSelected(bytes);
    } else {
      final file = File(image.path);
      onPhotoSelected(file);
    }
  }
}

Future<void> pickMediaFiles({
  required ValueChanged<List<dynamic>> onFilesSelected,
  List<String>? allowedExtensions, // مثال: ['jpg', 'png', 'mp4']
}) async {
  // final result = await FilePicker.platform.pickFiles(
  //   allowMultiple: true,
  //   type: allowedExtensions == null ? FileType.media : FileType.custom,
  //   allowedExtensions: allowedExtensions,
  //   withData: kIsWeb, // نحتاج البيانات مباشرة للويب
  // );

  // if (result != null && result.files.isNotEmpty) {
  //   List<dynamic> files = [];

  //   for (final file in result.files) {
  //     if (kIsWeb) {
  //       // على الويب منستعمل Uint8List
  //       files.add(file.bytes); // Uint8List
  //     } else {
  //       files.add(File(file.path!)); // File
  //     }
  //   }

  //   onFilesSelected(files);
  // }
}
