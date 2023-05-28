import 'package:asm/app/ui/main/database.dart';
import 'package:asm/app/ui/main/home.dart';
import 'package:asm/app/ui/main/user.dart';
import 'package:asm/config_app.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String bodyName = "home";

  @override
  Widget build(BuildContext context) {
    Widget body = const Center(
      child: Text("Error: Something wrong"),
    );
    if (bodyName == "home") {
      body = Home();
    } else if (bodyName == "db") {
      body = Database();
    } else if (bodyName == "user") {
      body = User();
    }
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: white,
          border: Border(
            top: BorderSide(width: 0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: iconSize,
              icon: Image.asset('assets/images/icon_home.png'),
              onPressed: () {
                setState(() {
                  bodyName = "home";
                });
              },
            ),
            IconButton(
              iconSize: iconSize,
              icon: Image.asset('assets/images/icon_database.png'),
              onPressed: () {
                setState(() {
                  bodyName = "db";
                });
              },
            ),
            IconButton(
              iconSize: iconSize,
              icon: Image.asset('assets/images/icon_user.png'),
              onPressed: () {
                setState(
                  () {
                    bodyName = "user";
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
