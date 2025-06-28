import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';
import 'package:med_tech_admin/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/Header.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/sidebar.dart';
import 'package:med_tech_admin/features/products/presentation/views/products_view.dart';

import '../../../data/pages.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  int selectedIndex = 0;

  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
          children: [
            Sidebar(
              selectedIndex: selectedIndex,
              onItemSelected: onItemSelected,
            ),
            Expanded(
              child: ListView(
                children: [
                  Header(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: pages[selectedIndex],
                  ),
                ],
              ),
            ),
          ],
        )
        : ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Sidebar(
                selectedIndex: selectedIndex,
                onItemSelected: onItemSelected,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Header(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: pages[selectedIndex],
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
