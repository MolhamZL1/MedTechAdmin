import 'package:flutter/material.dart';


class HeaderMaintenanceView extends StatelessWidget {
  const HeaderMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Maintenance Management",
          style: Theme
              .of(context)
              .textTheme
              .headlineLarge,
        ),
      ),
      subtitle: Text(
        "Track and manage equipment maintenance requests",
        style: Theme
            .of(context)
            .textTheme
            .bodyMedium,
      ),

    );
  }
}