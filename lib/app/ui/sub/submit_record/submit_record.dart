import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/ui/sub/submit_record/step_content.dart';
import 'package:asm/app/ui/sub/submit_record/step_datetime.dart';
import 'package:asm/app/ui/sub/submit_record/step_location.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubmitRecord extends StatelessWidget {
  SubmitRecord({super.key});

  Record record = Record();
  final RecordSubmitBloc bloc = RecordSubmitBloc();
  List<String> birdTypeList = [];

  @override
  Widget build(BuildContext context) {
    Widget body = SafeArea(
      child: Column(
        children: [
          TopBar(title: 'Submit Record'),
          Expanded(
            child: BlocConsumer<RecordSubmitBloc, RecordSubmitState>(
              bloc: bloc,
              buildWhen: (previous, current) =>
                  current is StepChanged || current != previous,
              listener: (context, state) {
                if (state is StepChanged) {
                  record = state.record;
                }
                if (state is PhotoUpdate) {
                  record = state.record;
                }
                if (state is SubmitDataSuccess) {
                  context.pop();
                }
                if (state is SubmitDataFailed) {
                  showAlertDialog(context, state.msg);
                }
              },
              builder: (context, state) {
                if (state is GetInitDataSuccess) {
                  birdTypeList = state.dataList;
                }
                if (state is RecordSubmitInitial) {
                  bloc.add(GetInitData());
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Step ${record.step} of 3',
                          style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                        ),
                        const SizedBox(height: 24),
                        if (record.step == 1) ...[
                          LocationStep(
                            record: record,
                            bloc: bloc,
                          ),
                        ] else if (record.step == 2) ...[
                          DateTimeStep(record: record, bloc: bloc)
                        ] else if (record.step == 3) ...[
                          ContentStep(
                            record: record,
                            bloc: bloc,
                            typeOfBird: birdTypeList,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: body,
    );
  }

  showAlertDialog(BuildContext context, String msg) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        context.pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Submit Failed"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
