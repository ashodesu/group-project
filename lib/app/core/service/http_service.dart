import 'dart:async';
import 'dart:convert';

import 'package:asm/app/core/obj/regist_info.dart';
import 'package:asm/app/core/obj/user_info.dart';
import 'package:asm/config.dart';
import 'package:asm/app/core/obj/login_info.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  FutureOr userLogin(LoginInfo loginInfo);
  FutureOr getUserInfo(String token);
  FutureOr getUserPost(String token);
  FutureOr updateUserInfo(String token, UserInfo info);
  FutureOr getDatabaseInfo(int page);
  FutureOr searchDatabase(String keywords);
  FutureOr userRegist(RegistInfo info);
  FutureOr getRecord(int page);
  factory HttpService() => _HttpService();
}

class _HttpService implements HttpService {
  final HttpConfig config = HttpConfig();
  final DatabaseConfig databaseConfig = DatabaseConfig();
  final ReportConfig reportConfig = ReportConfig();
  @override
  FutureOr userLogin(LoginInfo loginInfo) async {
    Map jsonMap = {
      "identifier": loginInfo.id,
      "password": loginInfo.password,
    };
    http.Response response = await http.post(
      Uri.parse("${config.host}${config.login}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
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

  @override
  Future<FutureOr> getUserPost(String token) async {
    http.Response userResponse = await http.get(
      Uri.parse("${config.host}${config.getUser}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Map userBody = jsonDecode(userResponse.body);
    int id = userBody['id'];
    http.Response response = await http.get(
      Uri.parse(
          "${config.host}${config.report}?filters[postByUserID][\$eq]=$id"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    Map body = jsonDecode(response.body);
    return body;
  }

  @override
  Future<FutureOr> updateUserInfo(String token, UserInfo info) async {
    Map body = {
      "id": info.id,
      "username": info.userName,
      "email": info.email,
      "firstName": info.firstName,
      "lastName": info.lastName,
      "birthday": info.birthday,
    };
    http.Response response = await http.put(
      Uri.parse("${config.host}${config.changeUserInfo}${info.id}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    Map res = jsonDecode(response.body);
    return res;
  }

  @override
  FutureOr getDatabaseInfo(int page) async {
    http.Response response = await http.get(
      Uri.parse(
          "${config.host}${config.database}?populate=*&sort[0]=creatureName%3Aasc&pagination[page]=$page&pagination[pageSize]=${databaseConfig.pageSize}"),
    );
    Map res = jsonDecode(response.body);
    return res;
  }

  @override
  FutureOr searchDatabase(String keywords) async {
    http.Response response = await http.get(
      Uri.parse(
          "${config.host}${config.database}?populate=*&filters[\$or][0][creatureName][\$contains]=$keywords&filters[\$or][1][creatureSciName][\$contains]=$keywords"),
    );
    Map res = jsonDecode(response.body);
    return res;
  }

  @override
  FutureOr userRegist(RegistInfo info) async {
    Map jsonMap = {
      "username": info.userName,
      "email": info.email,
      "password": info.password,
      "firstName": info.firstName,
      "lastName": info.lastName,
      "birthday": info.birthday,
    };
    print(jsonEncode(jsonMap));
    http.Response response = await http.post(
      Uri.parse("${config.host}${config.regist}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(jsonMap),
    );
    Map body = jsonDecode(response.body);
    return body;
  }

  @override
  FutureOr getRecord(int page) async {
    http.Response response = await http.get(
      Uri.parse(
          "${config.host}${config.report}?populate=*&sort[0]=createdAt%3Adesc&pagination[page]=${page.toString()}&pagination[pageSize]=${reportConfig.pageSize}&filters[IsVisible]=true"),
    );
    Map res = jsonDecode(response.body);
    return res;
  }
}
