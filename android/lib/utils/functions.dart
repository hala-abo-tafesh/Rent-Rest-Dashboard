import 'package:admin_interface/page/login_page.dart';
import 'package:admin_interface/page/side_bar_menu.dart';
import 'package:admin_interface/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void navigateTo(widget)=> Navigator.push(
  Get.context!,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(Widget widget) {
  Navigator.pushAndRemoveUntil(
    Get.context!,
    MaterialPageRoute(builder: (context) => widget), (Route<dynamic> route) => false,
  );
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  switch (state) {
    case ToastState.SUCCESS:
      return Colors.green;
    case ToastState.ERROR:
      return Colors.red;
    case ToastState.WARNING:
      return Colors.amber;
  }
}

void showSnackBar(String message, ToastState state) {
  Get.snackbar(
    '', // Title (optional)
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: chooseToastColor(state),
    colorText: Colors.white,
    borderRadius: 8,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
    icon: _getIcon(state),
  );
}

/// Optional: Add icon based on state
Widget _getIcon(ToastState state) {
  switch (state) {
    case ToastState.SUCCESS:
      return const Icon(Icons.check_circle, color: Colors.white);
    case ToastState.ERROR:
      return const Icon(Icons.error, color: Colors.white);
    case ToastState.WARNING:
      return const Icon(Icons.warning, color: Colors.white);
  }
}

Widget getRoute(){
  if(CacheHelper.getData(key: 'token') != null){
    return SideBarMenu();
  }
  return LoginPage();
}
