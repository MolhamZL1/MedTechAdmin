import 'package:flutter/material.dart';

import 'widgets/PersonalInfoSettings.dart';
import 'widgets/ProfilePictureSettings.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePictureSettings(),
        SizedBox(height: 32),
        PersonalInfoSettings(),
      ],
    );
  }
}
