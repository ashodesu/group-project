import 'package:asm/app/ui/components/database_card.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class Database extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(title: 'Database'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DatabaseCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
