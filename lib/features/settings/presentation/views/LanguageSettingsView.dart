import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/CategoryDropdown.dart';

import '../../../../core/functions/Container_decoration.dart';

class LanguageSettingsView extends StatelessWidget {
  const LanguageSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Language & Region",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 24),
          Text(
            "Language",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 450,
            child: CategoryDropdown(
              categories: ["Arabic", "English"],
              onChanged: (value) {},
              selected: "Arabic",
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Currency",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 450,
            child: CategoryDropdown(
              categories: ["US Dollar (USD)", "Syrian Pound (SP)"],
              onChanged: (value) {},
              selected: "US Dollar (USD)",
            ),
          ),
        ],
      ),
    );
  }
}
