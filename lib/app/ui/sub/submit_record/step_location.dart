import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/dropdown_field.dart';
import 'package:asm/app/ui/components/textfield_square.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class LocationStep extends StatelessWidget {
  const LocationStep({super.key, required this.record, required this.bloc});

  final Record record;
  final RecordSubmitBloc bloc;
  @override
  Widget build(BuildContext context) {
    Record recordWrite = record;
    return Form(
      child: Column(
        children: [
          TextFieldSquare(
            labelText: 'Address',
            onChanged: (val) {
              recordWrite.locate.details = val;
            },
            initialValue: recordWrite.locate.details,
          ),
          const SizedBox(height: 24),
          DropDownField(
            items: [],
            label: 'Sub-District',
            onChanged: (val) {},
          ),
          const SizedBox(height: 24),
          DropDownField(
            items: [],
            label: 'District',
            onChanged: (val) {},
          ),
          const SizedBox(height: 24),
          DropDownField(
            items: [],
            label: 'Area',
            onChanged: (val) {},
          ),
          const SizedBox(height: 24),
          TextFieldSquare(
            labelText: 'Countries/Region',
            readOnly: true,
            initialValue: record.locate.nation,
          ),
          const SizedBox(height: 24),
          SquareButton(
            onPressed: () {
              bloc.add(NextStep(record: recordWrite));
            },
            height: screenHeight * 0.04,
            width: screenWidth * 0.04,
            child: Text(
              "Next",
              style: TextStyle(
                fontFamily: fontStyle,
                fontSize: 20,
                color: black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
