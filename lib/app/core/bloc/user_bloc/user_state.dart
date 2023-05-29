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

class GetInfoFailed extends UserState {}

class UpdateInfoSuccess extends UserState {}

class UpdateInfoFailed extends UserState {}

class LogoutSuccess extends UserState {}
