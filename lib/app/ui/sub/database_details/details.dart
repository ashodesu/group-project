import 'package:asm/app/core/bloc/database_bloc/database_bloc.dart';
import 'package:asm/app/core/obj/database.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/database_text.dart';
import 'package:asm/app/ui/components/post_card.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class DatabaseDetails extends StatefulWidget {
  final DatabaseObject data;
  final DatabaseBloc bloc;
  final ScrollController scrollController;
  final double scrollOffset;
  final List<Record>? dataList;

  DatabaseDetails({
    super.key,
    required this.data,
    required this.bloc,
    required this.scrollController,
    required this.scrollOffset,
    required this.dataList,
  });

  @override
  State<DatabaseDetails> createState() => _DatabaseDetailsState();
}

class _DatabaseDetailsState extends State<DatabaseDetails> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    double smallPaddingSize = screenWidth * 0.005;
    double paddingSize = screenWidth * 0.015;
    BirdAttributes ba = widget.data.attributes!;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: smallPaddingSize),
              child: IconButton(
                onPressed: () {
                  widget.scrollController.animateTo(
                    widget.scrollOffset,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  widget.bloc.add(GoDB());
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSize),
          child: Column(
            children: [
              Image.network(widget.data.attributes!.photoUrl!),
              const SizedBox(height: 16),
              DBTextLine(text: ["Name:", ba.name]),
              DBTextLine(text: ["SciName:", ba.sciName]),
              DBTextLine(text: ["Characteristics:", ba.characteristics]),
              DBTextLine(text: ["Distribution:", ba.distribution]),
              DBTextLine(text: ["Habits:", ba.habits]),
              DBTextLine(text: ["Latest Update:", ba.updateAt.toString()]),
              DBTextLine(text: [
                "Nuber Of Records:",
                widget.dataList != null
                    ? widget.dataList!.length.toString()
                    : "Error"
              ]),
            ],
          ),
        ),
        SquareButton(
          onPressed: () {
            widget.scrollController.animateTo(
              widget.scrollController.offset + 300,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
            setState(() {
              show = true;
            });
          },
          height: screenHeight * 0.05,
          width: screenWidth,
          child: Text(
            'Show All Records',
            style: TextStyle(
              fontFamily: fontStyle,
              fontSize: 24,
            ),
          ),
        ),
        if (show && widget.dataList != null) ...[
          for (Record i in widget.dataList!) ...[PostCard(data: i)],
        ],
      ],
    );
  }
}
