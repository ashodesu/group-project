import 'package:asm/config.dart';
import 'package:encrypt/encrypt.dart';

bool checkDateFormat(String date) {
  RegExp dateFormat = RegExp(r'[0-9]{2}/[0-9]{2}/[0-9]{4}');
  if (dateFormat.hasMatch(date) && date.length == 10) {
    int year = int.tryParse(date.substring(6, 10)) ?? 0;
    int month = int.tryParse(date.substring(3, 5)) ?? 0;
    int day = int.tryParse(date.substring(0, 2)) ?? 0;
    if (year <= DateTime.now().year && year >= DateTime.now().year - 10) {
      if (month <= 12 && month > 0) {
        if (day <= getDaysInMonth(year, month)) {
          return true;
        }
      }
    }
  }
  return false;
}

int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  return daysInMonth[month - 1];
}

bool checkTimeFormat(String time) {
  RegExp timeFormat = RegExp(r'[0-9]{2}:[0-9]{2}');
  if (timeFormat.hasMatch(time) && time.length == 5) {
    int hours = int.tryParse(time.substring(0, 2)) ?? -1;
    int mins = int.tryParse(time.substring(3, 5)) ?? -1;
    if (hours <= 24 && mins <= 60 && hours >= 0 && mins >= 0) {
      return true;
    }
  }
  return false;
}

int countInString(String countItem, String str) {
  int count = 0;
  for (var i = 0; i < str.length; i += 1) {
    if (str[i] == countItem) {
      count += 1;
    }
  }
  return count;
}

int checkStringChangedPosition(String ostr, String nstr, String? changedItem) {
  int length = 0;
  if (ostr.length < nstr.length) {
    length = ostr.length;
  } else {
    length = nstr.length;
  }
  for (var i = 0; i < length; i += 1) {
    if (ostr[i] != nstr[i]) {
      if (changedItem != null) {
        if (ostr[i] == changedItem) {
          return i;
        }
      } else {
        return length;
      }
    }
  }
  return length;
}

String? checkStringAdded(String ostr, String nstr) {
  int length = 0;
  if (ostr.length < nstr.length) {
    length = nstr.length;
    for (var i = 0; i < length; i += 1) {
      try {
        if (ostr[i] != nstr[i]) {
          return nstr[i];
        }
      } catch (e) {
        return nstr[i];
      }
    }
  }
  return null;
}

List<String> getArea() {
  return ["Hong Kong Island", "Kowloon", "New Territories", "Other Island"];
}

List<String> getDistrict(String? area) {
  if (area == "Hong Kong Island") {
    return [
      "Central and Western",
      "Wan Chai",
      "Eastern",
      "Southern",
    ];
  }
  if (area == "Kowloon") {
    return [
      "Yau Tsim Mong",
      "Sham Shui Po",
      "Wong Tai Sin",
      "Kwun Tong",
    ];
  }
  if (area == "New Territories") {
    return [
      "Kwai Tsing",
      "Tsuen Wan",
      "Tuen Mun",
      "Yuen Long",
      "North",
      "Tai Po",
      "Sha Tin",
      "Sai Kung",
    ];
  }
  return ["Please First Select Aear"];
}

encryptAES(String plainText) {
  final SecConfig config = SecConfig();
  String encrypted;
  final key = Key.fromUtf8(config.key);
  final iv = IV.fromLength(config.iv);
  final encrypter = Encrypter(AES(key));
  encrypted = encrypter.encrypt(plainText, iv: iv).base64;
  return encrypted;
}

decryptAES(String encrypted) {
  String decrypted;
  final SecConfig config = SecConfig();
  final key = Key.fromUtf8(config.key);
  final iv = IV.fromLength(config.iv);
  final encrypter = Encrypter(AES(key));
  decrypted = encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);
  return decrypted;
}
