import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/core/widgets/CategoryDropdown.dart';

import '../../../../core/entities/InfoCardEntity.dart';
import '../../../products/presentation/views/widgets/InfoCardList.dart';

class DesktopDashboardView extends StatelessWidget {
  const DesktopDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderDashboardView(),
        SizedBox(height: 24),
        InfoCardList(entities: dashboardinfolist),
        SizedBox(height: 24),
        Container(
          decoration: containerDecoration(context),
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quick Actions",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 24),
              Row(children: [ActionCard()]),
            ],
          ),
        ),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(8),
      color: Colors.grey.shade400,
      dashPattern: [4, 4],
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add, color: Colors.white),
              ),
              SizedBox(width: 16),
              Icon(FontAwesomeIcons.cube, color: AppColors.primary, size: 20),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "Add new Product",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            "Add medical equipment to inventory",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

List<InfoCardEntity> dashboardinfolist = [
  InfoCardEntity(
    text: "Total Revenue",
    count: "\$245,670",

    icon: const Icon(
      FontAwesomeIcons.dollarSign,
      color: Colors.green,
      size: 30,
    ),
  ),
  InfoCardEntity(
    text: "Active Rentals",
    count: "156",

    icon: const Icon(Icons.calendar_today_outlined, color: Colors.blueAccent),
  ),
  InfoCardEntity(
    text: "Pending Orders",
    count: "43",
    icon: const Icon(
      Icons.shopping_cart_outlined,
      color: Colors.deepOrangeAccent,
    ),
  ),
  InfoCardEntity(
    text: "Maintenance Requests",
    count: "12",
    icon: const Icon(Icons.build_outlined, color: Colors.deepPurple),
  ),
];

class HeaderDashboardView extends StatefulWidget {
  const HeaderDashboardView({super.key});

  @override
  State<HeaderDashboardView> createState() => _HeaderDashboardViewState();
}

class _HeaderDashboardViewState extends State<HeaderDashboardView> {
  List<String> categories = [
    "Last 7 days",
    "Last 30 days",
    "Last 6 months",
    "Last 1 year",
    "All time",
  ];
  String selected = "Last 6 months";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Welcome back! Here's what's happening with your medical equipment business.",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: CategoryDropdown(
        categories: categories,
        onChanged: (value) {
          setState(() => selected = value!);
        },
        selected: selected,
      ),
    );
  }
}
