part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class GetUsersLoadingState extends UsersState{}
final class GetUsersSuccessState extends UsersState{}
final class GetUsersFailureState extends UsersState{}

final class AcceptLoadingState extends UsersState{}
final class AcceptSuccessState extends UsersState{}
final class AcceptFailureState extends UsersState{}

final class RejectLoadingState extends UsersState{}
final class RejectSuccessState extends UsersState{}
final class RejectFailureState extends UsersState{}