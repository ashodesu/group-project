import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/core/method.dart';
import 'package:asm/components/button_square.dart';
import 'package:asm/components/dropdown_field.dart';
import 'package:asm/components/textfield_square.dart';
import 'package:asm/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeStep extends StatelessWidget {
  DateTimeStep({super.key, required this.record, required this.bloc});

  final Record record;
  final RecordSubmitBloc bloc;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Record recordWrite = record;
    String oldDate = 'DD/MM/YYYY';
    String oldTime = 'HH:MM';
    RegExp numberReg = RegExp(r'[0-9]+$');
    if (recordWrite.observationDate != null) {
      oldDate = DateFormat('dd/MM/yyyy').format(recordWrite.observationDate!);
    }
    if (recordWrite.startingTime != null) {
      oldTime = recordWrite.startingTime!;
    }
    dateController.text = oldDate;
    timeController.text = oldTime;
    return Form(
      child: Column(
        children: [
          TextFieldSquare(
            labelText: 'Observation Date',
            controller: dateController,
            onChanged: (val) {
              if (val != null) {
                if (countInString("/", val) < 2) {
                  dateController.text = oldDate;
                  dateController.selection = TextSelection.collapsed(
                      offset:
                          checkStringChangedPosition(oldDate, val, "/") + 1);
                } else {
                  String? added = checkStringAdded(oldDate, val);
                  print("added: $added");
                  if (added != null) {
                    if (!numberReg.hasMatch(added)) {
                      dateController.text = oldDate;
                      dateController.selection = TextSelection.collapsed(
                          offset:
                              checkStringChangedPosition(oldDate, val, null));
                    } else {
                      oldDate = val;
                    }
                  } else {
                    oldDate = val;
                  }
                  if (checkDateFormat(val)) {
                    recordWrite.observationDate =
                        DateFormat('dd/MM/yyyy').parse(val);
                  }
                }
              }
            },
          ),
          const SizedBox(height: 24),
          TextFieldSquare(
            labelText: 'Starting Time',
            controller: timeController,
            onChanged: (val) {
              if (val != null) {
                if (countInString(":", val) < 1) {
                  timeController.text = oldTime;
                  timeController.selection = TextSelection.collapsed(
                      offset:
                          checkStringChangedPosition(oldTime, val, ":") + 1);
                } else {
                  String? added = checkStringAdded(oldTime, val);

                  if (added != null) {
                    if (!numberReg.hasMatch(added)) {
                      timeController.text = oldTime;
                      timeController.selection = TextSelection.collapsed(
                          offset:
                              checkStringChangedPosition(oldTime, val, null));
                    } else {
                      oldTime = val;
                    }
                  } else {
                    oldTime = val;
                  }
                  if (checkTimeFormat(val)) {
                    recordWrite.startingTime = val;
                  }
                }
              }
            },
          ),
          const SizedBox(height: 24),
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
        ],
      ),
    );
  }
}
