import 'dart:convert';

import 'package:asm/app/core/obj/database.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/config.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  HttpService httpService = HttpService();
  HttpConfig config = HttpConfig();
  DatabaseBloc() : super(DatabaseInitial()) {
    on<GetData>((event, emit) async {
      try {
        Map res = await httpService.getDatabaseInfo(event.page, event.pageSize);
        if (res['data'] != null) {
          List jsonList = res['data'];
          List<DatabaseObject> dataList = [];
          for (var i in jsonList) {
            DatabaseObject data = DatabaseObject();
            BirdAttributes attributes = BirdAttributes();
            data.id = i['id'];
            attributes.name = i['attributes']['creatureName'];
            attributes.sciName = i['attributes']['creatureSciName'];
            attributes.characteristics =
                i['attributes']['creautreCharacteristics'];
            attributes.distribution = i['attributes']['creatureDistribution'];
            attributes.habits = i['attributes']['creatureHabits'];
            attributes.createAt = i['attributes']['createdAt'] != null
                ? DateTime.parse(i['attributes']['createdAt']).toLocal()
                : null;
            attributes.updateAt = i['attributes']['updatedAt'] != null
                ? DateTime.parse(i['attributes']['updatedAt']).toLocal()
                : null;
            attributes.lang = i['attributes']['locale'];
            attributes.photoUrl =
                "${config.host}${i['attributes']['creaturePhoto']['data']['attributes']['formats']['thumbnail']['url']}";
            data.attributes = attributes;
            dataList.add(data);
          }
          emit(GetDataSuccess(page: event.page, dataList: dataList));
        } else {
          emit(GetDataFailed());
        }
      } catch (e) {
        print(e);
        emit(GetDataFailed());
      }
    });
    on<ToDetails>((event, emit) {
      emit(ShowDetails(event.data, event.scrollController, event.scrollOffset));
    });
    on<GoDB>((event, emit) {
      emit(ShowDatabase());
    });
    on<SearchDatabase>(
      (event, emit) async {
        try {
          Map res = await httpService.searchDatabase(event.keywords);
          if (res['data'] != null) {
            List jsonList = res['data'];
            List<DatabaseObject> dataList = [];
            for (var i in jsonList) {
              DatabaseObject data = DatabaseObject();
              BirdAttributes attributes = BirdAttributes();
              data.id = i['id'];
              attributes.name = i['attributes']['creatureName'];
              attributes.sciName = i['attributes']['creatureSciName'];
              attributes.characteristics =
                  i['attributes']['creautreCharacteristics'];
              attributes.distribution = i['attributes']['creatureDistribution'];
              attributes.habits = i['attributes']['creatureHabits'];
              attributes.createAt = i['attributes']['createdAt'] != null
                  ? DateTime.parse(i['attributes']['createdAt']).toLocal()
                  : null;
              attributes.updateAt = i['attributes']['updatedAt'] != null
                  ? DateTime.parse(i['attributes']['updatedAt']).toLocal()
                  : null;
              attributes.lang = i['attributes']['locale'];
              attributes.photoUrl =
                  "${config.host}${i['attributes']['creaturePhoto']['data']['attributes']['formats']['thumbnail']['url']}";
              data.attributes = attributes;
              dataList.add(data);
            }
            emit(SearchSuccess(dataList, event.searching));
          } else {
            emit(SearchFailed());
          }
        } catch (e) {
          print(e);
          emit(SearchFailed());
        }
      },
    );
  }
}
