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

  void login(){
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoadingState());
    DioHelper.postData(
      url: 'login',
      data: {
        'login' : emailController.text,
        'password' : passwordController.text
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value);
      CacheHelper.saveData(key: 'token', value: loginModel?.token);
      navigateAndFinish(SideBarMenu());
      showSnackBar('Success', ToastState.SUCCESS);
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      showSnackBar(error.toString(), ToastState.ERROR);
      emit(LoginFailureState());
    });
  }
}
