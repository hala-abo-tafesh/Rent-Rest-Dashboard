import 'package:admin_interface/cubits/sidebar_cubit/side_bar_cubit.dart';
import 'package:admin_interface/cubits/theme_cubit/theme_cubit.dart';
import 'package:admin_interface/cubits/users_cubit/users_cubit.dart';
import 'package:admin_interface/theme/colors.dart';
import 'package:admin_interface/widgets/side_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SideBarCubit>(create: (context) => SideBarCubit()),
        BlocProvider<UsersCubit>(create: (context) => UsersCubit()..getUsers()),
      ],
      child: BlocBuilder<SideBarCubit, SideBarState>(
        builder: (context, state) {
          final sideCubit = context.read<SideBarCubit>();
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Scaffold(
            body: Row(
              children: [
                Container(
                  width: 230,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Admin Panel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                            icon: Icon(
                              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                              color: AppColors.primary,
                            ),
                            tooltip: isDark ? 'Light mode' : 'Dark mode',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: sideCubit.screens.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: SideBarItem(index: index),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.transparent,
                    child: sideCubit.screens[sideCubit.selectedPageIndex],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
