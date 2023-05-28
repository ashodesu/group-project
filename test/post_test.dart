import 'dart:convert';

import 'package:asm/config.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  HttpConfig config = HttpConfig();
  Map jsonMap = {"identifier": "user1", "password": "12345"};
  http.Response response = await http.post(
    Uri.parse("https://squareinhk.com/api/auth/local"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(jsonMap),
  );
  Map body = jsonDecode(response.body);
  if (body['jwt'] != null) {
    print(body['jwt']);
  } else {
    print("failed");
  }
}
