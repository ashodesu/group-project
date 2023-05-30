import 'package:asm/app/core/bloc/login_bloc/login_bloc.dart';
import 'package:asm/app/core/bloc/user_bloc/user_bloc.dart';
import 'package:asm/app/core/obj/login_info.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/textfield_change_radius.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Login extends StatelessWidget {
  final bool? mode;
  final UserBloc? userBloc;
  Login({super.key, this.mode, this.userBloc});
  LoginBloc bloc = LoginBloc();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  LoginInfo info = LoginInfo();

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
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
          BlocConsumer<LoginBloc, LoginState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is LoginInitial) {}
              if (state is LoginSuccess || state is Logined) {
                if (mode == null || mode == false) {
                  context.go('/home');
                }
                if (mode == true) {
                  userBloc!.add(GetUserInfo());
                }
              }
              if (state is LoginFailed) {
                controller1.clear();
                controller2.clear();
                info = LoginInfo();
                showAlertDialog(context, state.msg);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Form(
                    key: key,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                      child: Column(
                        children: [
                          TextFieldRadiusToSquare(
                            labelText: 'Username',
                            onSaved: (value) {
                              info.id = value;
                            },
                            autocorrect: false,
                            controller: controller1,
                            validate: (value) {
                              if (value == null || value == "") {
                                return "Username can't be Emty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          TextFieldRadiusToSquare(
                            labelText: 'Password',
                            onSaved: (value) {
                              info.password = value;
                            },
                            hideText: true,
                            autocorrect: false,
                            controller: controller2,
                            validate: (value) {
                              if (value == null || value == "") {
                                return "Password can't be Emty";
                              }
                              return null;
                            },
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
                        onPressed: () {
                          context.push('/regist');
                        },
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
                          if (key.currentState!.validate()) {
                            key.currentState!.save();
                            bloc.add(UserLogin(info: info));
                          }
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
                      if (mode == null || mode == false) {
                        context.go('/home');
                      }
                      if (mode == true) {
                        userBloc!.add(GetUserInfo());
                      }
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
              );
            },
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String msg) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        context.pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Login Failed"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
