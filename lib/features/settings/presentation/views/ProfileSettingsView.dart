import 'package:flutter/material.dart';

import '../../../../core/functions/Container_decoration.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(32),
          decoration: containerDecoration(context),
        ),
        SizedBox(height: 32),
        Container(
          padding: EdgeInsets.all(32),
          decoration: containerDecoration(context),
        ),
      ],
    );
  }
}
