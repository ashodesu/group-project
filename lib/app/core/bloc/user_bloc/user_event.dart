part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserEvent {}

class ChangeUserInfo extends UserEvent {}

class UpdateUserInfo extends UserEvent {
  final UserInfo userInfo;

  UpdateUserInfo({required this.userInfo});
}

class Logout extends UserEvent {}

class ToMyRecord extends UserEvent {}

class ToUserInfo extends UserEvent {}

class RemoveReport extends UserEvent {
  final int reportId;

  RemoveReport(this.reportId);
}
