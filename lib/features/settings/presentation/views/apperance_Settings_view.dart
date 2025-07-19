import 'package:flutter/material.dart';

import '../../../../core/functions/Container_decoration.dart';
import 'widgets/ThemePreferences.dart';

class AppearanceSettingsView extends StatelessWidget {
  const AppearanceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(32),
          decoration: containerDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Theme Preferences",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 24),
              ThemePreferences(),
            ],
          ),
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
