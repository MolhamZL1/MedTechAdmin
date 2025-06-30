import 'package:flutter/material.dart';

class HeaderOrdersView extends StatelessWidget {
  const HeaderOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Orders",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Manage customers orders and sales",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      
    );
  }
}
