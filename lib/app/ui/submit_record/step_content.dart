import 'dart:io';
import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/textfield_square.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContentStep extends StatelessWidget {
  const ContentStep({super.key, required this.record, required this.bloc});

  final Record record;
  final RecordSubmitBloc bloc;
  @override
  Widget build(BuildContext context) {
    Record recordWrite = record;

    List<File> imageList = recordWrite.imageList ?? [];

    Future pickImage() async {
      try {
        print("Start");
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        print("Waiting");
        if (image == null) return false;
        print("Waiting 2");
        imageList.add(File(image.path));
        if (imageList.length == imageList.length + 1) return false;
        print("Success");
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
                recordWrite.imageList = imageList;
                bloc.add(AddPhoto(record: recordWrite));
              }
            },
            height: screenHeight * 0.04,
            width: screenWidth * 0.04,
            child: Text('Pick Photo'),
          ),
          const SizedBox(height: 24),
          if (imageList.isNotEmpty) ...[
            Center(
              child: Container(
                height: 500,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i in imageList) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Image.file(i),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          TextFieldSquare(
            labelText: "Desription",
            maxLine: 2,
            maxLength: 62,
            textAlign: TextAlign.start,
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
