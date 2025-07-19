import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/theme/theme_cubit.dart';
import 'side_bar/SettingsSideBarItem.dart';

class ThemePreferences extends StatefulWidget {
  const ThemePreferences({super.key});

  @override
  State<ThemePreferences> createState() => _ThemePreferencesState();
}

class _ThemePreferencesState extends State<ThemePreferences> {
  final items = [
    {
      'title': 'Light Mode',
      'icon': Icons.light_mode_outlined,
      'subtitle': 'Lighten up your day',
      'mode': ThemeMode.light,
    },
    {
      'title': 'Dark Mode',
      'icon': Icons.dark_mode_outlined,
      'subtitle': 'Get cozy with the dark',
      'mode': ThemeMode.dark,
    },
    {
      'title': 'System',
      'icon': Icons.phone_iphone_outlined,
      'subtitle': 'Follows your device\'s theme',
      'mode': ThemeMode.system,
    },
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final themeMode = context.read<ThemeCubit>().state;
    selectedIndex = items.indexWhere((item) => item['mode'] == themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        items.length,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              final mode = items[index]['mode'] as ThemeMode;
              context.read<ThemeCubit>().setTheme(mode);
            },
            child: SettingsSideBarItem(
              isSelected: index == selectedIndex,
              item: items[index],
            ),
          ),
        ),
      ),
    );
  }
}
