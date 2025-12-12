import 'package:admin_interface/models/admin_model.dart';
import 'package:admin_interface/widgets/request_card.dart';
import 'package:admin_interface/widgets/user_card.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = AdminModel.adminData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard();
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }
}
