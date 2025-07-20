import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/services/local_storage_service.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() async {
    final mode = await LocalStorageService.getItem(LocalStorageKeys.themeMode);
    if (mode == null) {
      emit(ThemeMode.light);
      return;
    }

    switch (mode) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      case 'system':
        emit(ThemeMode.system);
        break;
      default:
        emit(ThemeMode.light);
    }
  }

  void setTheme(ThemeMode mode) async {
    if (state == mode) return;

    switch (mode) {
      case ThemeMode.light:
        await LocalStorageService.setItem(LocalStorageKeys.themeMode, 'light');
        break;
      case ThemeMode.dark:
        await LocalStorageService.setItem(LocalStorageKeys.themeMode, 'dark');
        break;
      case ThemeMode.system:
        await LocalStorageService.setItem(LocalStorageKeys.themeMode, 'system');
        break;
    }
    emit(mode);
  }
}
