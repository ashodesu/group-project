import 'package:asm/components/button_square.dart';
import 'package:asm/components/textfield_change_radius.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: fontStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
              child: Column(
                children: [
                  const TextFieldRadiusToSquare(
                    labelText: 'Username',
                    onSaved: null,
                    autocorrect: false,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  const TextFieldRadiusToSquare(
                    labelText: 'Password',
                    onSaved: null,
                    hideText: true,
                    autocorrect: false,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquareButton(
                onPressed: null,
                height: screenHeight * 0.04,
                width: screenWidth * 0.04,
                child: Text(
                  "Regist",
                  style: TextStyle(
                    color: black,
                    fontSize: 20,
                    fontFamily: fontStyle,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.025),
              SquareButton(
                onPressed: () {
                  context.go('/home');
                },
                height: screenHeight * 0.04,
                width: screenWidth * 0.04,
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: black,
                    fontSize: 20,
                    fontFamily: fontStyle,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              context.go('/home');
            },
            child: const Text(
              'Login Later',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                color: blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
