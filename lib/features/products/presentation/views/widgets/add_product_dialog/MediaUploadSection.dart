import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../../../core/functions/infoContainerDcoration.dart';
import '../../../../../../core/utils/app_colors.dart';

class MediaUploadSection extends StatelessWidget {
  final String title;
  final List<Uint8List> files;
  final VoidCallback onUpload;
  final ValueChanged<int> onDelete;
  final bool isImage;

  const MediaUploadSection({
    super.key,
    required this.title,
    required this.files,
    required this.onUpload,
    required this.isImage,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: infoContainerDcoration(),
      width: 350,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(icon: const Icon(Icons.upload), onPressed: onUpload),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                files.asMap().entries.map((entry) {
                  final index = entry.key;
                  final file = entry.value;

                  return Stack(
                    children: [
                      isImage
                          ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                file,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          : const Icon(Icons.videocam, size: 48),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => onDelete(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
