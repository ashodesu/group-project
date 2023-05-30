class HttpConfig {
  String host = "https://squareinhk.com";
  String login = "/api/auth/local";
  String getUser = "/api/users/me";
  String report = "/api/survey-reports";
  String changeUserInfo = "/api/users/";
  String database = "/api/creature-dbs";
  String regist = "/api/auth/local/register";
  String upload = "/api/upload";
}

class DatabaseConfig {
  int pageSize = 10;
}

class ReportConfig {
  int pageSize = 20;
}
