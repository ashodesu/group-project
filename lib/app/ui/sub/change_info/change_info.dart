import 'package:asm/app/core/bloc/record_submit_bloc/record_submit_bloc.dart';
import 'package:asm/app/core/bloc/user_bloc/user_bloc.dart';
import 'package:asm/app/core/obj/user_info.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/textfield_square.dart';
import 'package:asm/app/ui/sub/submit_record/step_content.dart';
import 'package:asm/app/ui/sub/submit_record/step_datetime.dart';
import 'package:asm/app/ui/sub/submit_record/step_location.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/app/core/obj/record.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeUserInfoPage extends StatelessWidget {
  ChangeUserInfoPage({super.key});

  final UserBloc bloc = UserBloc();
  UserInfo info = UserInfo();

  @override
  Widget build(BuildContext context) {
    Widget body = SafeArea(
      child: Column(
        children: [
          TopBar(title: 'Change Information'),
          Expanded(
            child: BlocConsumer<UserBloc, UserState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is UpdateInfoSuccess) {
                  context.pop();
                }
                if (state is UpdateInfoFailed) {
                  showAlertDialog(context);
                }
              },
              builder: (context, state) {
                if (state is GetInfoSuccess) {
                  info = state.userInfo;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            child: Column(
                              children: [
                                const SizedBox(height: 24),
                                TextFieldSquare(
                                  labelText: "First Name",
                                  textAlign: TextAlign.start,
                                  initialValue: info.firstName,
                                  onChanged: (val) {
                                    info.firstName = val;
                                  },
                                ),
                                const SizedBox(height: 24),
                                TextFieldSquare(
                                  labelText: "Last Name",
                                  textAlign: TextAlign.start,
                                  initialValue: info.lastName,
                                  onChanged: (val) {
                                    info.lastName = val;
                                  },
                                ),
                                const SizedBox(height: 24),
                                TextFieldSquare(
                                  labelText: "Birthday",
                                  textAlign: TextAlign.start,
                                  initialValue: info.birthday,
                                  onChanged: (val) {
                                    info.birthday = val;
                                  },
                                ),
                                const SizedBox(height: 24),
                                TextFieldSquare(
                                  labelText: "Email",
                                  textAlign: TextAlign.start,
                                  initialValue: info.email,
                                  onChanged: (val) {
                                    info.email = val;
                                  },
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SquareButton(
                                      onPressed: () {
                                        bloc.add(
                                            UpdateUserInfo(userInfo: info));
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is UserInitial) {
                  bloc.add(GetUserInfo());
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: body,
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        context.pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Update Failed"),
      content: Text("Please login again and try again."),
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
