import 'package:admin_interface/page/requests_page.dart';
import 'package:admin_interface/page/users_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'side_bar_state.dart';

class SideBarCubit extends Cubit<SideBarState> {
  SideBarCubit() : super(SideBarInitial());

  List<Widget> screens = [
    RequestsPage(),
    UsersPage(),

  ];

  List<String> title = [
    'Requests',
    'Users',

  ];

  List<IconData> icons = [
    Icons.send,
    Icons.person,
  ];

  int selectedPageIndex = 0;

  void changeSelectedIndex({required int index}){
    selectedPageIndex = index;
    emit(SideBarChange());
  }
}
