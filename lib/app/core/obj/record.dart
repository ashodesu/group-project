import 'dart:io';

import 'package:asm/app/core/obj/locate.dart';

class Record {
  int step = 1;
  int? id;
  Locate locate = Locate();
  DateTime? observationDate;
  DateTime? uploadTime;
  String? startingTime;
  String? details;
  String? typeOfBird;
  File? imageList;
  String? photoPath;
}
