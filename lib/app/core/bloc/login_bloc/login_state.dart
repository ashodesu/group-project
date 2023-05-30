part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String msg;

  LoginFailed(this.msg);
}

class RegistSuccess extends LoginState {}

class RegistFailed extends LoginState {
  final String msg;
  @override
  List<Object> get props => [msg];
  RegistFailed(this.msg);
}
