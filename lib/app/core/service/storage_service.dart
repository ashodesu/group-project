import 'dart:async';

import 'package:asm/app/core/obj/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  FutureOr saveToken(String key);
  FutureOr getToken();
  FutureOr clearToken();
  FutureOr saveItems(int key);
  FutureOr getItmes();
  factory StorageService() => _StorageService();
}

class _StorageService implements StorageService {
  @override
  FutureOr saveToken(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("jwt", key);
  }

  @override
  FutureOr getToken() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? key = pref.getString('jwt');
      if (key != null) {
        return key;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  FutureOr clearToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('jwt');
  }

  @override
  FutureOr getItmes() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int? key = await pref.getInt('objectNum');
      return key;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  FutureOr saveItems(int key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("objectNum", key);
  }
}
