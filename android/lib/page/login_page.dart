import 'package:admin_interface/cubits/login_cubit/login_cubit.dart';
import 'package:admin_interface/widgets/custom_text_field.dart';
import 'package:admin_interface/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<LoginCubit>();

          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: cubit.formKey, // <-- use cubit's global key
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Icon
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(
                                Icons.admin_panel_settings,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),

                            const SizedBox(height: 16),

                            /// Title
                            Text(
                              'Admin Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sign in to continue',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 24),

                            /// Email Field
                            CustomTextField(
                              controller: cubit.emailController,
                              label: 'Email',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            /// Password Field
                            CustomTextField(
                              controller: cubit.passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            /// Login Button
                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                return CustomButton(
                                  text: 'Login',
                                  isLoading: state is LoginLoadingState,
                                  onPressed: () {
                                    // if (cubit.formKey.currentState!.validate()) {
                                      cubit.login();
                                    // }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
