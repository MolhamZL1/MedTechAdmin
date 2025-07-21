import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/functions/error_dialog.dart';
import 'package:med_tech_admin/core/functions/pick_image_from_device.dart';
import 'package:med_tech_admin/core/widgets/CustomCircleLoading.dart';
import 'package:med_tech_admin/core/widgets/showsuccessDialog.dart';
import 'package:med_tech_admin/features/settings/presentation/cubits/upload_photo/upload_photo_cubit.dart';

import '../../../../../core/functions/Container_decoration.dart';
import '../../../../../core/widgets/show_err_dialog.dart';

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
                  BlocConsumer<UploadPhotoCubit, UploadPhotoState>(
                    listener: (context, state) {
                      if (state is UploadPhotoSuccess) {
                        showsuccessDialog(
                          context: context,
                          title: "Success",
                          description: "Photo uploaded successfully",
                        );
                      }
                      if (state is UploadPhotoError) {
                        showerrorDialog(
                          context: context,
                          title: "Error",
                          description: state.errMessage,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is UploadPhotoLoading) {
                        return CustomCircleLoading();
                      }
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (image != null) {
                                context.read<UploadPhotoCubit>().uploadPhoto(
                                  photo: image!,
                                );
                              } else {
                                showWebErrorToast(
                                  context,
                                  "Please select an image",
                                );
                              }
                            },
                            child: Text("Upload Photo"),
                          ),
                          SizedBox(width: 16),
                          TextButton(onPressed: () {}, child: Text("Remove")),
                        ],
                      );
                    },
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
