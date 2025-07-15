import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSettingsView(),
        SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SettingsSideBar()),
            SizedBox(width: 32),
            Expanded(
              flex: 3,
              child: ProfileSettingsView(),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({
    super.key,
  });

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

class SettingsSideBar extends StatelessWidget {
  const SettingsSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Settings", style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}

class HeaderSettingsView extends StatelessWidget {
  const HeaderSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Manage your account and system preferences",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
