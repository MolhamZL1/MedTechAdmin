import 'package:flutter/material.dart';

import '../../../../../../core/functions/Container_decoration.dart';
import '../../../../data/pages.dart';
import 'SettingsSideBarItem.dart';

class SettingsSideBar extends StatefulWidget {
  const SettingsSideBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  @override
  State<SettingsSideBar> createState() => _SettingsSideBarState();
}

class _SettingsSideBarState extends State<SettingsSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: containerDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Settings", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 16),
          ...List.generate(
            settingsItemSideBar.length,
            (index) => InkWell(
              onTap: () => widget.onItemTapped(index),
              child: SettingsSideBarItem(
                item: settingsItemSideBar[index],
                isSelected: widget.selectedIndex == index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
