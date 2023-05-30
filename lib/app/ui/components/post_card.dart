import 'package:asm/app/core/obj/database.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/core/service/http_service.dart';
import 'package:asm/config.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

class PostCard extends StatefulWidget {
  final Record data;
  final bool? mode;
  final Function()? onPress;

  const PostCard({super.key, required this.data, this.mode, this.onPress});
  @override
  State<PostCard> createState() =>
      _PostCardState(data: data, mode: mode ?? false, onPress: onPress);
}

class _PostCardState extends State<PostCard> {
  final Record data;
  bool like = false;
  final bool mode;
  final Function()? onPress;

  _PostCardState({
    required this.data,
    required this.mode,
    this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: greyLite,
      child: Container(
        width: screenWidth,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.typeOfBird ?? "None",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: fontStyle,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Image.network(data.photoPath!),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        data.details ?? 'None',
                        style: TextStyle(fontSize: 18),
                      )),
                      Row(
                        children: [
                          if (mode) ...[
                            IconButton(
                              onPressed: onPress,
                              icon: Icon(Icons.delete),
                            ),
                          ] else ...[
                            IconButton(
                              onPressed: () async {
                                List<DatabaseObject>? dataList =
                                    await getDBData(data.typeOfBird!);
                                if (dataList != null) {
                                  showAlertDB(context, dataList[0]);
                                }
                              },
                              icon: const Icon(
                                Icons.library_books,
                                size: 32,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                            "Appeared in ${data.locate.district} around ${data.observationDate!.day}-${data.observationDate!.month}-${data.observationDate!.year} ${data.observationDate!.hour}:${data.observationDate!.minute}"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "Upload at ${data.uploadTime!.day}-${data.uploadTime!.month}-${data.uploadTime!.year}")
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<DatabaseObject>?> getDBData(String birdType) async {
    HttpService _httpService = HttpService();
    HttpConfig _config = HttpConfig();
    try {
      Map res = await _httpService.getDataWithName(birdType);
      if (res['data'] != null) {
        List jsonList = res['data'];
        List<DatabaseObject> dataList = [];
        for (var i in jsonList) {
          DatabaseObject data = DatabaseObject();
          BirdAttributes attributes = BirdAttributes();
          data.id = i['id'];
          attributes.name = i['attributes']['creatureName'];
          attributes.sciName = i['attributes']['creatureSciName'];
          attributes.characteristics =
              i['attributes']['creautreCharacteristics'];
          attributes.distribution = i['attributes']['creatureDistribution'];
          attributes.habits = i['attributes']['creatureHabits'];
          attributes.createAt = i['attributes']['createdAt'] != null
              ? DateTime.parse(i['attributes']['createdAt']).toLocal()
              : null;
          attributes.updateAt = i['attributes']['updatedAt'] != null
              ? DateTime.parse(i['attributes']['updatedAt']).toLocal()
              : null;
          attributes.lang = i['attributes']['locale'];
          attributes.photoUrl =
              "${_config.host}${i['attributes']['creaturePhoto']['data']['attributes']['formats']['thumbnail']['url']}";
          data.attributes = attributes;
          dataList.add(data);
        }
        return dataList;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  showAlertDB(BuildContext context, DatabaseObject data) {
    Widget closeButton = Transform.rotate(
      angle: math.pi / -2,
      child: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded)),
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        data.attributes!.name!,
        style: TextStyle(fontFamily: fontStyle, fontSize: 28),
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: screenHeight * 0.4,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(data.attributes!.photoUrl!),
              Row(
                children: [
                  Text(
                    "SciName:",
                    style: TextStyle(fontFamily: fontStyle, fontSize: 20),
                  ),
                  SizedBox(width: screenWidth * 0.005),
                  Flexible(child: Text(data.attributes!.sciName!)),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Text(
                    "Characteristics:",
                    style: TextStyle(fontFamily: fontStyle, fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(child: Text(data.attributes!.characteristics!)),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Text(
                    "Distribution:",
                    style: TextStyle(fontFamily: fontStyle, fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(child: Text(data.attributes!.distribution!)),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Text(
                    "Habits:",
                    style: TextStyle(fontFamily: fontStyle, fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(child: Text(data.attributes!.habits!)),
                ],
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [closeButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
