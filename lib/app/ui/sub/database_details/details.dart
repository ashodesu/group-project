import 'package:asm/app/core/bloc/database_bloc/database_bloc.dart';
import 'package:asm/app/core/obj/database.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:asm/app/ui/components/database_text.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseDetails extends StatelessWidget {
  final DatabaseObject data;
  final DatabaseBloc bloc;
  final ScrollController scrollController;
  final double scrollOffset;

  const DatabaseDetails({
    super.key,
    required this.data,
    required this.bloc,
    required this.scrollController,
    required this.scrollOffset,
  });

  @override
  Widget build(BuildContext context) {
    double smallPaddingSize = screenWidth * 0.005;
    double paddingSize = screenWidth * 0.015;
    BirdAttributes ba = data.attributes!;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: smallPaddingSize),
              child: IconButton(
                onPressed: () {
                  scrollController.animateTo(
                    scrollOffset,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  bloc.add(GoDB());
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
              Image.network(data.attributes!.photoUrl!),
              const SizedBox(height: 16),
              DBTextLine(text: ["Name:", ba.name]),
              DBTextLine(text: ["SciName:", ba.sciName]),
              DBTextLine(text: ["Characteristics:", ba.characteristics]),
              DBTextLine(text: ["Distribution:", ba.distribution]),
              DBTextLine(text: ["Habits:", ba.habits]),
              DBTextLine(text: ["Latest Update:", ba.updateAt.toString()])
            ],
          ),
        ),
      ],
    );
  }
}
