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
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (Get.context == null) return;

    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: chooseToastColor(state),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      maxWidth: 400,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3),
      icon: _getIcon(state),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  });
}


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
