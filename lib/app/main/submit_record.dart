import 'package:asm/components/top_bar_app.dart';
import 'package:asm/obj/record.dart';
import 'package:flutter/material.dart';

class SubmitRecord extends StatelessWidget {
  SubmitRecord({super.key});

  final Record record = Record();

  @override
  Widget build(BuildContext context) {
    Widget body = SafeArea(
      child: Column(
        children: [
          const TopBar(title: 'Submit Record'),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    if (record.step == 1)
                      ...[]
                    else if (record.step == 2)
                      ...[]
                    else if (record.step == 3)
                      ...[],
                  ],
                ),
              ),
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
