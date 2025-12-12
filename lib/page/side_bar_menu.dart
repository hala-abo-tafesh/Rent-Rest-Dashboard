import 'package:admin_interface/cubits/sidebar_cubit/side_bar_cubit.dart';
import 'package:admin_interface/widgets/side_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SideBarCubit(),
      child: BlocBuilder<SideBarCubit, SideBarState>(
        builder: (context, state) {
          final cubit = context.read<SideBarCubit>();

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // elevation: 1,
              title: const Text(
                "Admin Panel",
                style: TextStyle(color: Colors.black),
              ),
            ),

            body: Row(
              children: [

                // -------------------- Sidebar --------------------
                Container(
                  width: 230,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    children: List.generate(
                      cubit.screens.length,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: SideBarItem(index: index),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.transparent,
                    child: cubit.screens[cubit.selectedPageIndex],
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
