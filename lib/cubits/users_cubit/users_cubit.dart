import 'package:admin_interface/models/users_model.dart';
import 'package:admin_interface/utils/cache_helper.dart';
import 'package:admin_interface/utils/dio_helper.dart';
import 'package:admin_interface/utils/functions.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  List<UsersModel> usersModel = [];
  List<UsersModel> requestsModel = [];

  Future<void> getUsers() async {
    emit(GetUsersLoadingState());

    try {
      final token = CacheHelper.getData(key: 'token') as String?;

      if (token == null || token.isEmpty) {
        emit(GetUsersFailureState());
        showSnackBar('Missing token', ToastState.ERROR);
        return;
      }

      final List<dynamic> data = await DioHelper.getData<List<dynamic>>(
        url: 'indexUsers',
        token: token,
      );

      usersModel = data
          .map((e) => UsersModel.fromJson(e as Map<String, dynamic>))
          .toList();

      emit(GetUsersSuccessState());
    } catch (error) {
      showSnackBar('Error loading users', ToastState.ERROR);
      print(error.toString());
      emit(GetUsersFailureState());
    }
  }

  void acceptUser({required int userID}){
    emit(AcceptLoadingState());
    DioHelper.postData(
      url: 'users/$userID/accept',
      token: CacheHelper.getData(key: 'token'),
      data: {},
    ).then((value) {
      emit(AcceptSuccessState());
      getUsers();
      showSnackBar('Success', ToastState.SUCCESS);
    }).catchError((error) {
      showSnackBar('error', ToastState.ERROR);
      emit(AcceptFailureState());
    });
  }

  void rejectUser({required int userID}){
    emit(RejectLoadingState());
    DioHelper.postData(
      url: 'users/$userID/ban',
      token: CacheHelper.getData(key: 'token'),
      data: {},
    ).then((value) {
      emit(RejectSuccessState());
      getUsers();
      showSnackBar('Success', ToastState.SUCCESS);
    }).catchError((error) {
      showSnackBar('error', ToastState.ERROR);
      emit(RejectFailureState());
    });
  }

  void deleteUser({required int userID}){
    emit(RejectLoadingState());
    DioHelper.deleteData(
      url: 'users/$userID/delete',
      token: CacheHelper.getData(key: 'token'),
      // data: {},
    ).then((value) {
      emit(RejectSuccessState());
      getUsers();
      showSnackBar('Success', ToastState.SUCCESS);
    }).catchError((error) {
      showSnackBar('error', ToastState.ERROR);
      emit(RejectFailureState());
    });
  }
}
