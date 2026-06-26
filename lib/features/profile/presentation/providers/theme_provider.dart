import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/theme_mode_entity.dart';

const _kThemeKey = 'app_theme_mode';

class ThemeNotifier extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    _loadFromPrefs();
    return AppThemeMode.system;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kThemeKey);
    if (saved != null) {
      state = AppThemeMode.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  Future<void> setTheme(AppThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kThemeKey, mode.name);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, AppThemeMode>(
  ThemeNotifier.new,
);


final flutterThemeModeProvider = Provider<ThemeMode>((ref) {
  final mode = ref.watch(themeProvider); 
  return switch (mode) {
    AppThemeMode.light  => ThemeMode.light,
    AppThemeMode.dark   => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };
});