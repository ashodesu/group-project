import 'package:asm/app/core/bloc/user_bloc/user_bloc.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/core/obj/user_info.dart';
import 'package:asm/app/ui/components/post_card.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:flutter/material.dart';

class MyRecord extends StatefulWidget {
  final UserBloc bloc;
  final UserInfo info;

  const MyRecord({super.key, required this.bloc, required this.info});

  @override
  State<MyRecord> createState() => _MyRecordState();
}

class _MyRecordState extends State<MyRecord> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          title: "MyRecord",
          buttonFunction: () {
            widget.bloc.add(ToUserInfo());
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (Record r in widget.info.recordList) ...[
                  PostCard(
                    data: r,
                    mode: true,
                    onPress: () {
                      setState(() {
                        widget.info.recordList.remove(r);
                      });
                      widget.bloc.add(RemoveReport(r.id!));
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
