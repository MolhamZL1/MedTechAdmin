import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/functions/pick_image_from_device.dart';

import '../../../../../core/functions/Container_decoration.dart';

class ProfilePictureSettings extends StatefulWidget {
  const ProfilePictureSettings({super.key});

  @override
  State<ProfilePictureSettings> createState() => _ProfilePictureSettingsState();
}

class _ProfilePictureSettingsState extends State<ProfilePictureSettings> {
  Uint8List? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile Picture",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  await pickImage(
                    onPhotoSelected: (value) {
                      image = value;
                    },
                  );
                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.file_upload_outlined, size: 50),
                ),
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload new picture",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Upload Photo"),
                      ),
                      SizedBox(width: 16),
                      TextButton(onPressed: () {}, child: Text("Remove")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
