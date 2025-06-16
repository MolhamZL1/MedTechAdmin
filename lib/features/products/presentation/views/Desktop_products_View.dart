import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';
import 'package:med_tech_admin/core/widgets/CategoryDropdown.dart';

import 'widgets/HeaderProductsView.dart';

class DesktopProductsView extends StatelessWidget {
  const DesktopProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [
      "All Categories",
      "Diagnostic",
      "Life Support",
      "Emergency",
      "Monitoring",
    ];
    return Column(
      children: [
        HeaderProductsView(),
        SizedBox(height: 24),
        Container(
          decoration: containerDecoration(),
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined),
                    hintText: "Search Products...",
                  ),
                ),
              ),
              Spacer(),
              CategoryDropdown(
                categories: categories,
                selected: categories[0],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        // GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //   ),
        //   itemBuilder: (context, index) => Placeholder(),
        // ),
      ],
    );
  }
}
