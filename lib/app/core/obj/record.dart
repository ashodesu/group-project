import 'dart:io';

import 'package:asm/app/core/obj/locate.dart';

class Record {
  int step = 1;
  Locate locate = Locate();
  DateTime? observationDate;
  String? observationType;
  String? startingTime;
  String? details;
  String? typeOfBird;
  List<File> imageList = [];
}
