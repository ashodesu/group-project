import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/textfield_square.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ContentStep extends StatefulWidget {
  const ContentStep(
      {super.key,
      required this.record,
      required this.bloc,
      required this.typeOfBird});

  final Record record;
  final RecordSubmitBloc bloc;
  final List<String> typeOfBird;

  @override
  State<ContentStep> createState() => _ContentStepState();
}

class _ContentStepState extends State<ContentStep> {
  final TextEditingController controller = TextEditingController();
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    Record recordWrite = widget.record;

    File? imageList = recordWrite.imageList;

    Future pickImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return false;
        imageList = File(image.path);
        recordWrite.photoPath = image.name;
        return true;
      } catch (e) {
        print("Get Image Failed: $e");
        return false;
      }
    }

    return Form(
      child: Column(
        children: [
          SquareButton(
            onPressed: () async {
              bool status = await pickImage();
              if (status == true) {
                recordWrite.photoPath = imageList!.path;
                recordWrite.imageList = imageList;
                widget.bloc.add(AddPhoto(record: recordWrite));
              }
            },
            height: screenHeight * 0.04,
            width: screenWidth * 0.04,
            child: Text('Pick Photo'),
          ),
          if (errorText.contains("Photo")) ...[
            Text(
              errorText,
              style: TextStyle(color: red),
            )
          ],
          const SizedBox(height: 24),
          if (imageList != null) ...[
            // Center(
            //   child: Container(
            //     height: 500,
            //     child: ListView(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       children: [
            // for (var i in imageList)...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.file(imageList!),
            ),
            // ]
            //       ],
            //     ),
            //   ),
            // ),
          ],
          const SizedBox(height: 24),
          CustomDropdown.search(
            hintText: recordWrite.typeOfBird ?? "Type of Bird",
            hintStyle: recordWrite.typeOfBird != null
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
            items: widget.typeOfBird,
            controller: controller,
            borderSide: const BorderSide(color: grey, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onChanged: (val) {
              recordWrite.typeOfBird = val;
            },
          ),
          if (errorText.contains("Bird")) ...[
            Text(
              errorText,
              style: TextStyle(color: red),
            )
          ],
          const SizedBox(height: 24),
          TextFieldSquare(
            labelText: "Desription",
            maxLine: 2,
            maxLength: 62,
            textAlign: TextAlign.start,
            onChanged: (val) {
              recordWrite.details = val;
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SquareButton(
                onPressed: () {
                  widget.bloc.add(PreviousStep(record: recordWrite));
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
                  if (recordWrite.photoPath == null) {
                    setState(() {
                      errorText = "Please Pick a Photo";
                    });
                  } else if (recordWrite.typeOfBird == null ||
                      recordWrite.typeOfBird == "") {
                    setState(() {
                      errorText = "Please Select Type of Bird";
                    });
                  } else {
                    setState(() {
                      errorText == "";
                    });
                    widget.bloc.add(SubmitData(recordWrite));
                  }
                },
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
          Row(
            children: [
              SquareButton(
                onPressed: () async {
                  final String? path = await getSavePath();
                },
                height: screenHeight * 0.04,
                width: screenWidth * 0.04,
                child: Text(
                  "Export CSV",
                  style: TextStyle(
                    fontFamily: fontStyle,
                    fontSize: 20,
                    color: black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
