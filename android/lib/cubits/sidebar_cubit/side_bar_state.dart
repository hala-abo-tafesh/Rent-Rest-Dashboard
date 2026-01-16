part of 'side_bar_cubit.dart';

@immutable
sealed class SideBarState {}

final class SideBarInitial extends SideBarState {}

final class SideBarChange extends SideBarState {}

final class SideBarThemeChanged extends SideBarState {}
