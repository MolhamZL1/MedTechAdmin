import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage({
  required ValueChanged<dynamic> onPhotoSelected,
}) async {
  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
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
