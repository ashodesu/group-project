part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserLogin extends LoginEvent {
  final LoginInfo info;
  const UserLogin({required this.info});
}
