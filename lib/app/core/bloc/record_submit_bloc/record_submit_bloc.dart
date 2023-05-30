import 'dart:io';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'record_submit_event.dart';
part 'record_submit_state.dart';

class RecordSubmitBloc extends Bloc<RecordSubmitEvent, RecordSubmitState> {
  HttpService httpService = HttpService();
  StorageService storageService = StorageService();
  RecordSubmitBloc() : super(RecordSubmitInitial()) {
    on<NextStep>((event, emit) {
      Record record = event.record;
      if (record.step < 3) {
        record.step += 1;
        emit(StepChanged(record: record));
      }
      emit(StepChangeError());
    });
    on<PreviousStep>(
      (event, emit) {
        Record record = event.record;
        if (record.step > 1) {
          record.step -= 1;
          emit(StepChanged(record: record));
        }
        emit(StepChangeError());
      },
    );
    on<AddPhoto>(
      (event, emit) {
        emit(PhotoUpdate(record: event.record));
        emit(PhotoUpdated());
      },
    );
    on<GetInitData>((event, emit) async {
      try {
        Map res = await httpService.getBirdList();
        List r = res['data'];
        List<String> dataList = [];
        for (Map data in r) {
          dataList.add(data['attributes']['creatureName']);
        }
        emit(GetInitDataSuccess(dataList));
      } catch (e) {
        print(e);
        emit(GetInitDataFailed(e.toString()));
      }
    });
    on<SubmitData>((event, emit) async {
      try {
        Record data = event.data;
        String token = await storageService.getToken();
        Map userRes = await httpService.getUserInfo(token);
        int userId = userRes['id'];
        var photoRes = await httpService.uploadPhoto(
            token, data.imageList!, data.photoPath!);
        if (photoRes is List) {
          data.photoId = photoRes[0]['id'];
          Map reportRes = await httpService.submitReport(token, data, userId);
          emit(SubmitDataSuccess());
        } else {
          if (photoRes['error']['name'] == "ForbiddenError") {
            emit(SubmitDataFailed("You have no permission to submit record!"));
          }
        }
      } catch (e) {
        print("Error: $e");
        emit(SubmitDataFailed(
            "!!!Unkown Error Please Contact Admin!!!!\nError Code:\n${e.toString()}"));
      }
    });
  }
}
