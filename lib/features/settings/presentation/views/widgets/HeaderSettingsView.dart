import 'package:flutter/material.dart';

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
