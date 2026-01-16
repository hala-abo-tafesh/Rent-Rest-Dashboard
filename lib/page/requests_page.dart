import 'package:admin_interface/cubits/users_cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/request_card.dart';
import '../theme/colors.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {

  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          final cubit = context.read<UsersCubit>();

          if (state is GetUsersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          final pending = cubit.usersModel
              .where((u) => u.status.trim().toLowerCase() == 'pending')
              .toList();

          if (pending.isEmpty) {
            return const Center(child: Text('No pending requests'));
          }

          return ListView.separated(
            itemCount: pending.length,
            itemBuilder: (context, index) {
              final user = pending[index];
              return RequestCard(
                user: user,
                onAccept: () => cubit.acceptUser(userID: user.id),
                onReject: () => cubit.rejectUser(userID: user.id),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
        },
      ),
    );
  }
}
