import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:asm/config.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final HttpService httpService = HttpService();
  final StorageService storageService = StorageService();
  final HttpConfig config = HttpConfig();
  RecordBloc() : super(RecordInitial()) {
    on<GetRecord>((event, emit) async {
      try {
        Map res = await httpService.getRecord(event.page);
        if (res['error'] == null) {
          List r = res['data'];
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
          emit(GetRecordSuccess(dataList, event.page));
        } else {
          emit(GetRecordFailed(res['error']['message']));
        }
      } catch (e) {
        print(e);
        emit(GetRecordFailed(e.toString()));
      }
    });
  }
}
