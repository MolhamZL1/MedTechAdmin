import 'package:flutter/material.dart';

import '../presentation/views/LanguageSettingsView.dart';
import '../presentation/views/ProfileSettingsView.dart';
import '../presentation/views/SecuritySettingsView.dart';
import '../presentation/views/apperance_Settings_view.dart';

List settingsPages = [
  ProfileSettingsView(),
  Securitysettingsview(),
  AppearanceSettingsView(),
  LanguageSettingsView(),
];
List settingsItemSideBar = [
  {
    "title": "Profile Settings",
    "subtitle": "Manage your personal information",
    "icon": Icons.person_outlined,
  },
  {
    "title": "Security",
    "subtitle": "Password and authentication settings",
    "icon": Icons.security_outlined,
  },

  {
    "title": "Appearance",
    "subtitle": "Theme and display settings",
    "icon": Icons.dark_mode_outlined,
  },
  {
    "title": "Language & Region",
    "subtitle": "Localization preferences",
    "icon": Icons.language_outlined,
  },
];
