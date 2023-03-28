import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/components/button_square.dart';
import 'package:asm/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class ContentStep extends StatelessWidget {
  const ContentStep({super.key, required this.record, required this.bloc});

  final Record record;
  final RecordSubmitBloc bloc;
  @override
  Widget build(BuildContext context) {
    Record recordWrite = record;
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SquareButton(
                onPressed: () {
                  bloc.add(PreviousStep(record: recordWrite));
                },
                height: screenHeight * 0.04,
                width: screenWidth * 0.04,
                child: Text(
                  "Previous",
                  style: TextStyle(
                    fontFamily: fontStyle,
                    fontSize: 20,
                    color: black,
                  ),
                ),
              ),
              SquareButton(
                onPressed: () {},
                height: screenHeight * 0.04,
                width: screenWidth * 0.04,
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontFamily: fontStyle,
                    fontSize: 20,
                    color: black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
