import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
            token, data.imageList!, data.imageList!.path.split('/').last);
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
    on<ExportCSV>((event, emit) async {
      try {
        Record record = event.data;
        List<List> row = [
          [
            "Type Of Bird",
            "Description",
            "Observation Date",
            "Appeared Time",
            "Region",
            "Area",
            "District",
            "Details",
            "Photo"
          ],
          [
            record.typeOfBird,
            record.details,
            DateFormat("dd/MM/yyyy").format(record.observationDate!),
            record.startingTime,
            record.locate.nation ?? "Hong Kong SAR",
            record.locate.area,
            record.locate.district,
            record.locate.details ?? "",
            record.imageList!.path
          ]
        ];
        File f = File(event.path + "/${record.typeOfBird}_Report.csv");
        if (!f.existsSync()) {
          await f.create(recursive: true);
        }
        String csv = const ListToCsvConverter().convert(row);
        f.writeAsString(csv);
        emit(ExportSuccess("Export Success"));
      } catch (e) {
        print("Error: $e");
        emit(ExportFailed("Export Filed"));
      }
    });
    on<ImportCSV>((event, emit) async {
      try {
        File f = File(event.result.files.first.path!);
        Record record = Record();
        List<List> csv = CsvToListConverter().convert(await f.readAsString());
        List data = csv[1];
        record.step = 3;
        record.typeOfBird = data[0];
        record.details = data[1];
        record.observationDate = DateFormat("dd/MM/yyyy").parse(data[2]);
        record.startingTime = data[3];
        record.locate.nation = data[4];
        record.locate.area = data[5];
        record.locate.district = data[6];
        record.locate.details = data[7];
        record.imageList = File(data[8]);
        emit(ImportSuccess("Import Success", record));
      } catch (e) {
        print("Error: $e");
        emit(ImportFailed("Import Failed"));
      }
    });
  }
}
