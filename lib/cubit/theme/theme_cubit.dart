import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../services/theme_storage_service.dart';


class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._storage) : super(ThemeMode.system) {
    _loadInitialTheme();
  }

  final ThemeStorageService _storage;

  Future<void> _loadInitialTheme() async {
    final ThemeMode? stored = await _storage.loadThemeMode();
    if (stored != null) {
      emit(stored);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    await _storage.saveThemeMode(mode);
  }

  Future<void> toggleTheme() async {
    ThemeMode next;
    switch (state) {
      case ThemeMode.light:
        next = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        next = ThemeMode.light;
        break;
      case ThemeMode.system:
        // Default: go to light first.
        next = ThemeMode.light;
        break;
    }
    emit(next);
    await _storage.saveThemeMode(next);
  }
}

