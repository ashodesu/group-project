import 'package:asm/app/core/bloc/database_bloc/database_bloc.dart';
import 'package:asm/app/core/obj/database.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

class DatabaseCard extends StatelessWidget {
  final DatabaseObject data;
  final DatabaseBloc bloc;
  final ScrollController controller;

  const DatabaseCard({
    super.key,
    required this.data,
    required this.bloc,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    BirdAttributes ba = data.attributes!;
    StorageService storageService = StorageService();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: greyLite,
      child: InkWell(
        onTap: () async {
          controller.animateTo(0,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
          bloc.add(ToDetails(data, controller, controller.offset));
        },
        child: Container(
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  ba.photoUrl!,
                  width: screenWidth * 0.05,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: "),
                    Flexible(child: Text("${ba.name}")),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SciName: "),
                    Flexible(child: Text("${ba.sciName}")),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text("Latest Update: ${ba.updateAt}")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
