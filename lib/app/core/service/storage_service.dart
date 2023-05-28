import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  FutureOr saveToken(String key);
  FutureOr getToken();
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? key = await pref.getString('jwt');
    if (key != null) {
      return key;
    } else {
      return null;
    }
  }
}
