import 'package:admin_interface/models/login_model.dart';
import 'package:admin_interface/page/side_bar_menu.dart';
import 'package:admin_interface/utils/cache_helper.dart';
import 'package:admin_interface/utils/dio_helper.dart';
import 'package:admin_interface/utils/functions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginModel? loginModel;

  void login() {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoadingState());

    DioHelper.postData(
      url: 'login',
      data: {
        'login': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value);

      if (loginModel?.user == null) {
        showSnackBar('Invalid user data', ToastState.ERROR);
        emit(LoginFailureState());
        return;
      }

      if (loginModel?.user?.role != 'admin') {
        showSnackBar('Access denied. Admin only.', ToastState.ERROR);
        emit(LoginFailureState());
        return;
      }

      if (loginModel?.token == null || loginModel!.token!.isEmpty) {
        showSnackBar('Failed to retrieve access token', ToastState.ERROR);
        emit(LoginFailureState());
        return;
      }

      CacheHelper.saveData(key: 'token', value: loginModel!.token);
      showSnackBar('Login successful', ToastState.SUCCESS);
      navigateAndFinish(SideBarMenu());
      emit(LoginSuccessState());
    }).catchError((error) {
      showSnackBar('Invalid email or passowrd', ToastState.ERROR);
      emit(LoginFailureState());
    });
  }
}
