class HttpConfig {
  String host = "https://squareinhk.com";
  String login = "/api/auth/local";
  String getUser = "/api/users/me";
  String postCounter = "/api/creature-dbs?filters[postByUserID][\$eq]=1";
  String changeUserInfo = "/api/users/";
  String database = "/api/creature-dbs";
}

class DatabaseConfig {
  int pageSize = 10;
}
