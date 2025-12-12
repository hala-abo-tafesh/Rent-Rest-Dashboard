import 'package:admin_interface/page/side_bar_menu.dart';
import 'package:flutter/material.dart';
import 'package:admin_interface/models/admin_model.dart';
import 'page/users_page.dart';
import 'widgets/request_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SideBarMenu(),
    );
  }
}
