import 'package:admin_interface/cubits/theme_cubit/theme_cubit.dart';
import 'package:admin_interface/page/side_bar_menu.dart';
import 'package:admin_interface/theme/dark_theme.dart';
import 'package:admin_interface/theme/light_theme.dart';
import 'package:admin_interface/utils/cache_helper.dart';
import 'package:admin_interface/utils/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async{
  DioHelper.init();
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final themeCubit = context.read<ThemeCubit>();

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightTheme.theme,
            darkTheme: DarkTheme.theme,
            themeMode: themeCubit.themeMode,
            home: const SideBarMenu(),
          );
        },
      ),
    );
  }
}
