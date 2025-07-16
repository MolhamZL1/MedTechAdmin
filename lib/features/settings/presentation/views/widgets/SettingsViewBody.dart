import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';

import '../../../data/pages.dart';
import 'HeaderSettingsView.dart';
import 'side_bar/SettingsSideBar.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  int selectedIndex = 0;
  onitemTapped(int index) {
    selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSettingsView(),
        SizedBox(height: 24),
        Responsive.isDesktop(context)
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SettingsSideBar(
                    selectedIndex: selectedIndex,
                    onItemTapped: onitemTapped,
                  ),
                ),
                SizedBox(width: 32),
                Expanded(flex: 3, child: settingsPages[selectedIndex]),
              ],
            )
            : Column(
              children: [
                SettingsSideBar(
                  selectedIndex: selectedIndex,
                  onItemTapped: onitemTapped,
                ),
                SizedBox(height: 32),
                settingsPages[selectedIndex],
              ],
            ),
      ],
    );
  }
}
