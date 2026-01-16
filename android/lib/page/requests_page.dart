import 'package:admin_interface/cubits/users_cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/request_card.dart';
import '../theme/colors.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.textPrimaryDark
            : AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          final cubit = context.read<UsersCubit>();

          final pending = cubit.usersModel
              .where((u) => u.status.trim().toLowerCase() == 'pending')
              .toList();

          if(state is GetUsersLoadingState) {
            return Center(child: CircularProgressIndicator(color: AppColors.primary,));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: pending.length,
            itemBuilder: (context, index) {
              final user = pending[index];

              return RequestCard(
                user: user,
                onAccept: () => cubit.acceptUser(userID : user.id),
                onReject: () => cubit.rejectUser(userID : user.id),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 0),
          );
        },
      ),
    );
  }
}
