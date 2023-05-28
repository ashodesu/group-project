import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class PostCard extends StatefulWidget {
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool like = false;
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
                    "Bird Type",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
              child: Image.asset('assets/images/bird.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Content"),
                  Row(
                    children: [
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
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Remix.message_3_fill),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
