import 'package:admin_interface/models/admin_model.dart';
import 'package:admin_interface/widgets/request_card.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = AdminModel.adminData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return RequestCard(user: users[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }
}
