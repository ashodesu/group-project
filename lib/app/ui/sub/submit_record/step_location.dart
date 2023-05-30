import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/core/method.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/textfield_square.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class LocationStep extends StatefulWidget {
  LocationStep({super.key, required this.record, required this.bloc});

  final Record record;
  final RecordSubmitBloc bloc;

  @override
  State<LocationStep> createState() => _LocationStepState(record: record);
}

class _LocationStepState extends State<LocationStep> {
  final TextEditingController controller1 = TextEditingController();

  final TextEditingController controller2 = TextEditingController();
  Record record;
  String errorText1 = "";
  _LocationStepState({required this.record});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFieldSquare(
            labelText: 'Details',
            onChanged: (val) {
              record.locate.details = val;
            },
            initialValue: record.locate.details,
          ),
          const SizedBox(height: 24),
          CustomDropdown.search(
            hintText: record.locate.area ?? "Area",
            hintStyle: record.locate.area != null
                ? const TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    color: black,
                    fontSize: 16,
                  )
                : const TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    color: grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
            controller: controller1,
            items: getArea(),
            borderSide: const BorderSide(color: grey, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onChanged: (val) {
              setState(() {
                record.locate.area = val;
              });
            },
          ),
          if (errorText1.contains("Area")) ...[
            Text(
              errorText1,
              style: const TextStyle(
                color: red,
              ),
            )
          ],
          const SizedBox(height: 24),
          if (record.locate.area == "Other Island") ...[
            TextFieldSquare(
              labelText: 'Island Name',
              onChanged: (val) {
                record.locate.district = val;
              },
              initialValue: record.locate.district,
            ),
          ] else ...[
            CustomDropdown.search(
              hintText: record.locate.district ?? "District",
              hintStyle: record.locate.district != null
                  ? const TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      color: black,
                      fontSize: 16,
                    )
                  : const TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      color: grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              items: getDistrict(record.locate.area),
              controller: controller2,
              borderSide: const BorderSide(color: grey, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onChanged: (val) {
                record.locate.district = val;
              },
            ),
          ],
          if (errorText1.contains('District')) ...[
            Text(
              errorText1,
              style: const TextStyle(
                color: red,
              ),
            )
          ],
          const SizedBox(height: 24),
          TextFieldSquare(
            labelText: 'Countries/Region',
            readOnly: true,
            initialValue: widget.record.locate.nation,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SquareButton(
                onPressed: () async {
                  final FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    widget.bloc.add(ImportCSV(result));
                  }
                },
                height: screenHeight * 0.04,
                width: screenWidth * 0.04,
                child: Text(
                  "Import CSV",
                  style: TextStyle(
                    fontFamily: fontStyle,
                    fontSize: 20,
                    color: black,
                  ),
                ),
              ),
              SquareButton(
                onPressed: () {
                  if (record.locate.area == null ||
                      record.locate.district == "") {
                    setState(() {
                      errorText1 = "Please Select Area";
                    });
                  } else if (record.locate.district == null ||
                      record.locate.district == "") {
                    errorText1 = "Please Select/Enter District";
                  } else {
                    errorText1 = "";
                  }
                  if (errorText1 == "") {
                    widget.bloc.add(NextStep(record: record));
                  }
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
