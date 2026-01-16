import 'package:admin_interface/cubits/users_cubit/users_cubit.dart';
import 'package:admin_interface/page/user_details_page.dart';
import 'package:admin_interface/theme/colors.dart';
import 'package:admin_interface/utils/functions.dart';
import 'package:admin_interface/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          final cubit = context.read<UsersCubit>();

          if(state is GetUsersLoadingState) {
            return Center(child: CircularProgressIndicator(color: AppColors.primary,));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: cubit.usersModel.length,
            itemBuilder: (context, index) {
              final user = cubit.usersModel[index];

              return UserCard(
                user: user,
                onShow: () => navigateTo(UserDetailsPage(user: cubit.usersModel[index])),
                onDelete: () {},
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 0),
          );
        },
      ),
    );
  }
}
