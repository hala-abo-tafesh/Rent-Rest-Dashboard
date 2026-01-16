import 'package:admin_interface/utils/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    isDark = CacheHelper.getData(key: 'is_dark') ?? false;
  }

  late bool isDark;

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  Future<void> toggleTheme() async {
    isDark = !isDark;
    await CacheHelper.saveData(key: 'is_dark', value: isDark);
    emit(ThemeChanged());
  }

  Future<void> setTheme(bool dark) async {
    isDark = dark;
    await CacheHelper.saveData(key: 'is_dark', value: isDark);
    emit(ThemeChanged());
  }
}
