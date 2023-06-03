import 'package:asm/app/core/bloc/login_bloc/login_bloc.dart';
import 'package:asm/app/core/bloc/user_bloc/user_bloc.dart';
import 'package:asm/app/core/obj/regist_info.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/textfield_change_radius.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegistPage extends StatelessWidget {
  final LoginBloc bloc = LoginBloc();
  RegistInfo info = RegistInfo();
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopBar(title: 'Regist'),
            Expanded(
              child: BlocConsumer<LoginBloc, LoginState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is RegistFailed) {
                    showAlertDialog(context, state.msg);
                  }
                  if (state is RegistSuccess) {
                    showSuccessDialog(context);
                    Future.delayed(Duration(seconds: 3), () {
                      context.pop();
                      context.pop();
                    });
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Form(
                          key: key,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.015),
                            child: Column(
                              children: [
                                TextFieldRadiusToSquare(
                                  labelText: 'Username',
                                  onSaved: (value) {
                                    info.userName = value;
                                  },
                                  autocorrect: false,
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
                                  validate: (value) {
                                    if (value == null || value == "") {
                                      return "Password can't be Emty";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                TextFieldRadiusToSquare(
                                  labelText: 'Email',
                                  onSaved: (value) {
                                    info.email = value;
                                  },
                                  autocorrect: false,
                                  validate: (value) {
                                    if (value == null || value == "") {
                                      return "Email can't be Emty";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                TextFieldRadiusToSquare(
                                  labelText: 'First Name',
                                  onSaved: (value) {
                                    if (value == "") {
                                      info.firstName = null;
                                    } else {
                                      info.firstName = value;
                                    }
                                  },
                                  autocorrect: false,
                                  validate: (value) {},
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                TextFieldRadiusToSquare(
                                  labelText: 'Last Name',
                                  onSaved: (value) {
                                    if (value == "") {
                                      info.lastName = null;
                                    } else {
                                      info.lastName = value;
                                    }
                                  },
                                  autocorrect: false,
                                  validate: (value) {},
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                TextFieldRadiusToSquare(
                                  labelText: 'Birthday',
                                  onSaved: (value) {
                                    if (value == "") {
                                      info.birthday = null;
                                    } else {
                                      info.birthday = value;
                                    }
                                  },
                                  autocorrect: false,
                                  validate: (value) {},
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
                                if (key.currentState!.validate()) {
                                  key.currentState!.save();
                                  bloc.add(UserRegist(info));
                                }
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
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
      title: Text(
        "Regist Failed",
        style: TextStyle(fontFamily: fontStyle),
      ),
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

  showSuccessDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Success",
        style: TextStyle(fontFamily: fontStyle),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
