import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

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
            InkWell(
              onDoubleTap: () {
                setState(() {
                  like = true;
                });
              },
              child: Image.network(data.photoPath!),
            ),
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
                              onPressed: () {
                                setState(() {
                                  if (like == false) {
                                    like = true;
                                  } else if (like == true) {
                                    like = false;
                                  }
                                });
                              },
                              icon: Icon(
                                Remix.heart_3_fill,
                                color: like == true ? red : black,
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
}
