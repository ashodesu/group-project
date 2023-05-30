import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/core/obj/user_info.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:asm/config.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StorageService storageService = StorageService();
  HttpService httpService = HttpService();
  HttpConfig config = HttpConfig();
  UserBloc() : super(UserInitial()) {
    on<GetUserInfo>((event, emit) async {
      try {
        String token = await storageService.getToken();
        Map response = await httpService.getUserInfo(token);
        if (response['id'] != null &&
            response['id'] != "" &&
            response['error'] == null) {
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
            List r = postRe['data'];
            List<Record> dataList = [];
            for (Map i in r) {
              Record data = Record();
              data.id = i['id'];
              data.typeOfBird = i["attributes"]['BirdName'];
              data.observationDate = i["attributes"]['BirdDate'] != null
                  ? DateTime.parse(i["attributes"]['BirdDate']).toLocal()
                  : null;
              data.uploadTime = i["attributes"]['updatedAt'] != null
                  ? DateTime.parse(i["attributes"]['updatedAt']).toLocal()
                  : null;
              data.details = i["attributes"]['BirdDeatils'];
              data.locate.nation = i["attributes"]['region'];
              data.locate.area = i["attributes"]['area'];
              data.locate.district = i["attributes"]['distrit'];
              data.locate.details = i["attributes"]['details'];
              data.photoPath =
                  "${config.host}${i["attributes"]['Photo']['data']['attributes']['url']}";
              dataList.add(data);
            }
            info.recordList = dataList;
          }
          emit(GetInfoSuccess(userInfo: info));
        } else {
          emit(GetInfoFailed("Token Expiry, Please Login Again"));
        }
      } catch (e) {
        print("Error:$e");
        emit(GetInfoFailed(
            "!!!Unknow Error Please Contact Admin!!!\nError Code:\n${e.toString()}"));
      }
    });
    on<UpdateUserInfo>((event, emit) async {
      try {
        String token = await storageService.getToken();
        Map res = await httpService.updateUserInfo(token, event.userInfo);
        if (res['error'] == null) {
          emit(UpdateInfoSuccess());
        } else {
          emit(UpdateInfoFailed(res['error']['message']));
        }
      } catch (e) {
        emit(UpdateInfoFailed(
            "!!!Unknow Error Please Contact Admin!!!\nError Code:\n${e.toString()}"));
      }
    });
    on<Logout>(
      (event, emit) {
        storageService.clearToken();
        emit(LogoutSuccess());
      },
    );
    on<ToMyRecord>((event, emit) {
      emit(ShowMyRecord());
    });
    on<ToUserInfo>((event, emit) {
      emit(ShowUserInfo());
    });
    on<RemoveReport>((event, emit) async {
      try {
        String token = await storageService.getToken();
        await httpService.removeReport(token, event.reportId);
      } catch (e) {
        print("Error: $e");
      }
    });
  }
}
