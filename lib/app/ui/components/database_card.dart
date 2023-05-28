import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class DatabaseCard extends StatefulWidget {
  @override
  State<DatabaseCard> createState() => _DatabaseCardState();
}

class _DatabaseCardState extends State<DatabaseCard> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: greyLite,
      child: InkWell(
        onTap: () {
          print('Hii');
        },
        child: Container(
          width: screenWidth,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Bird Type")],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Content"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
