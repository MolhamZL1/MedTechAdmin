import 'package:flutter/material.dart';


class HeaderFinancialView extends StatelessWidget {
  const HeaderFinancialView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Financial Reports",
          style: Theme
              .of(context)
              .textTheme
              .headlineLarge,
        ),
      ),
      subtitle: Text(
        "Track revenue, expenses, and profitability",
        style: Theme
            .of(context)
            .textTheme
            .bodyMedium,
      ),

    );
  }
}