import 'package:asm/app/core/bloc/record_bloc/record_bloc.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/app/ui/components/post_card.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final RecordBloc bloc = RecordBloc();
  List<Record> dataList = [];
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(title: 'Home'),
          Expanded(
            child: SingleChildScrollView(
              child: BlocConsumer<RecordBloc, RecordState>(
                bloc: bloc,
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is GetRecordSuccess) {
                    dataList = state.dataList;
                    page = 1;
                  }
                  if (state is RecordInitial) {
                    bloc.add(GetRecord(page));
                  }
                  return Column(
                    children: [
                      if (dataList != []) ...[
                        for (Record data in dataList) ...[
                          PostCard(data: data),
                        ],
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
