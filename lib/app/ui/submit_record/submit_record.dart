import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/ui/submit_record/step_content.dart';
import 'package:asm/app/ui/submit_record/step_datetime.dart';
import 'package:asm/app/ui/submit_record/step_location.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/dropdown_field.dart';
import 'package:asm/app/ui/components/textfield_square.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitRecord extends StatelessWidget {
  SubmitRecord({super.key});

  Record record = Record();
  final RecordSubmitBloc bloc = RecordSubmitBloc();

  @override
  Widget build(BuildContext context) {
    Widget body = SafeArea(
      child: Column(
        children: [
          const TopBar(title: 'Submit Record'),
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
              },
              builder: (context, state) {
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
                          LocationStep(record: record, bloc: bloc),
                        ] else if (record.step == 2) ...[
                          DateTimeStep(record: record, bloc: bloc)
                        ] else if (record.step == 3) ...[
                          ContentStep(record: record, bloc: bloc),
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
}
