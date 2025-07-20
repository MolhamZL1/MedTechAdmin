import 'package:flutter/material.dart';

class HeaderUsersView extends StatelessWidget {
  const HeaderUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "User Management",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Manage user accounts and permissions",
        style: Theme.of(context).textTheme.bodyMedium,
      ),

    );
  }
}
