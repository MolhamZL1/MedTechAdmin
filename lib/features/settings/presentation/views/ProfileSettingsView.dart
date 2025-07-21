import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/features/settings/domain/rpeos/settings_repo.dart';
import 'package:med_tech_admin/features/settings/presentation/cubits/upload_photo/upload_photo_cubit.dart';

import 'widgets/PersonalInfoSettings.dart';
import 'widgets/ProfilePictureSettings.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) => UploadPhotoCubit(getIt.get<SettingsRepo>()),
          child: ProfilePictureSettings(),
        ),
        SizedBox(height: 32),
        PersonalInfoSettings(),
      ],
    );
  }
}
