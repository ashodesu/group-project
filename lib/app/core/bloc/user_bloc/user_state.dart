part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class GetInfoSuccess extends UserState {
  final UserInfo userInfo;

  const GetInfoSuccess({required this.userInfo});
}

class GetInfoFailed extends UserState {
  final String msg;

  GetInfoFailed(this.msg);
}

class UpdateInfoSuccess extends UserState {}

class UpdateInfoFailed extends UserState {
  final String msg;

  UpdateInfoFailed(this.msg);
}

class LogoutSuccess extends UserState {}

class ShowMyRecord extends UserState {}

class ShowUserInfo extends UserState {}
