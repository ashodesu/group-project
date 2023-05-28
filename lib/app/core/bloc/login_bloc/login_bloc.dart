import 'package:asm/app/core/obj/login_info.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  HttpService httpService = HttpService();
  StorageService storageService = StorageService();
  LoginBloc() : super(LoginInitial()) {
    on<UserLogin>((event, emit) async {
      LoginInfo info = event.info;
      Map response = await httpService.userLogin(info);
      if (response["jwt"] != null) {
        storageService.saveToken(response["jwt"]);
        emit(LoginSuccess());
      } else {
        emit(LoginFailed());
      }
    });
  }
}
