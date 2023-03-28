import 'package:asm/components/top_bar_app.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(title: 'Home'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i <= 200; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(i.toString())],
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}