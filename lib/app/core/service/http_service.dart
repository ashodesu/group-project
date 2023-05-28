import 'dart:async';
import 'dart:convert';

import 'package:asm/config.dart';
import 'package:asm/app/core/obj/login_info.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  FutureOr userLogin(LoginInfo loginInfo);
  FutureOr getUserInfo(String token);
  factory HttpService() => _HttpService();
}

class _HttpService implements HttpService {
  final HttpConfig config = HttpConfig();
  @override
  FutureOr userLogin(LoginInfo loginInfo) async {
    Map jsonMap = {
      "identifier": loginInfo.id,
      "password": loginInfo.password,
    };
    http.Response response = await http.post(
      Uri.parse("${config.host}${config.login}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(jsonMap),
    );
    Map body = jsonDecode(response.body);
    return body;
  }

  @override
  Future<FutureOr> getUserInfo(String token) async {
    http.Response response = await http.get(
      Uri.parse("${config.host}${config.getUser}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Map body = jsonDecode(response.body);
    return body;
  }
}

checkKeyExpiry(String auth) {}
