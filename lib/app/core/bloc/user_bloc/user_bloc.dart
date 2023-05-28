import 'package:asm/app/core/obj/user_info.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StorageService storageService = StorageService();
  HttpService httpService = HttpService();
  UserBloc() : super(UserInitial()) {
    on<GetUserInfo>((event, emit) async {
      String token = await storageService.getToken();
      Map response = await httpService.getUserInfo(token);
      if (response['id'] != null && response['id'] != "") {
        UserInfo info = UserInfo();
        info.id = response['id'];
        info.userName = response['username'];
        info.email = response['email'];
        info.createAt = DateTime.tryParse(response['createdAt'])!.toLocal();
        info.updateAt = DateTime.tryParse(response['updatedAt'])!.toLocal();
        info.firstName = response['firstName'];
        info.lastName = response['lastName'];
        if (response['birthday'] != null) {
          info.birthday = DateTime.tryParse(response['birthday'])!.toLocal();
        }
        emit(GetInfoSuccess(userInfo: info));
      } else {
        emit(GetInfoFailed());
      }
    });
  }
}