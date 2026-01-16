import 'package:admin_interface/page/requests_page.dart';
import 'package:admin_interface/page/users_page.dart';
import 'package:admin_interface/utils/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'side_bar_state.dart';

class SideBarCubit extends Cubit<SideBarState> {
  SideBarCubit() : super(SideBarInitial()) {
    isDark = CacheHelper.getData(key: 'is_dark') ?? false;
  }

  late bool isDark;

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  List<Widget> screens = const [
    RequestsPage(),
    UsersPage(),
  ];

  List<String> title = const [
    'Requests',
    'Users',
  ];

  List<IconData> icons = const [
    Icons.send,
    Icons.person,
  ];

  int selectedPageIndex = 0;

  void changeSelectedIndex({required int index}) {
    selectedPageIndex = index;
    emit(SideBarChange());
  }

  Future<void> toggleTheme() async {
    isDark = !isDark;
    await CacheHelper.saveData(key: 'is_dark', value: isDark);
    emit(SideBarThemeChanged());
  }
}
