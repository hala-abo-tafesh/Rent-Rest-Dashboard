import 'package:admin_interface/cubits/sidebar_cubit/side_bar_cubit.dart';
import 'package:admin_interface/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarItem extends StatefulWidget {
  const SideBarItem({super.key, required this.index});

  final int index;

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SideBarCubit>();
    final isSelected = cubit.selectedPageIndex == widget.index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final idleIcon = isDark ? Colors.white70 : Colors.grey.shade700;
    final idleText = isDark ? Colors.white70 : Colors.grey.shade800;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => cubit.changeSelectedIndex(index: widget.index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.12)
                : isHovered
                ? (isDark ? Colors.white.withOpacity(0.08) : Colors.grey.withOpacity(0.12))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.18)
                  : (isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04)),
            ),
          ),
          child: Row(
            children: [
              Icon(
                cubit.icons[widget.index],
                color: isSelected ? AppColors.primary : idleIcon,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  cubit.title[widget.index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? AppColors.primary : idleText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
