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
      try {
        String token = await storageService.getToken();
        Map response = await httpService.getUserInfo(token);
        if (response['id'] != null &&
            response['id'] != "" &&
            response['error'] == null) {
          print('in');
          UserInfo info = UserInfo();
          info.id = response['id'];
          info.userName = response['username'];
          info.email = response['email'];
          info.createAt = DateTime.tryParse(response['createdAt'])!.toLocal();
          info.updateAt = DateTime.tryParse(response['updatedAt'])!.toLocal();
          info.firstName = response['firstName'];
          info.lastName = response['lastName'];
          info.birthday = response['birthday'];
          Map postRe = await httpService.getUserPost(token);
          if (postRe['meta']['pagination']['total'] != null) {
            info.postCount = postRe['meta']['pagination']['total'];
          }
          emit(GetInfoSuccess(userInfo: info));
        } else {
          emit(GetInfoFailed());
        }
      } catch (e) {
        emit(GetInfoFailed());
      }
    });
    on<UpdateUserInfo>((event, emit) async {
      String token = await storageService.getToken();
      Map res = await httpService.updateUserInfo(token, event.userInfo);
      if (res['error'] == null) {
        emit(UpdateInfoSuccess());
      } else {
        emit(UpdateInfoFailed());
      }
    });
    on<Logout>(
      (event, emit) {
        storageService.clearToken();
        emit(LogoutSuccess());
      },
    );
  }
}
