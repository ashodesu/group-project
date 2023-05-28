import 'package:asm/app/core/bloc/user_bloc/user_bloc.dart';
import 'package:asm/app/core/obj/user_info.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/app/ui/login.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class User extends StatelessWidget {
  UserInfo info = UserInfo();
  UserBloc bloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserBloc, UserState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is GetInfoSuccess) {
            info = state.userInfo;
          }
          if (state is GetInfoFailed) {
            context.go('/');
          }
        },
        builder: (context, state) {
          if (state is GetInfoSuccess) {
            return Column(
              children: [
                TopBar(title: 'User'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Hi ${info.userName} !',
                                style: TextStyle(
                                    fontFamily: fontStyle, fontSize: 32),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          SquareButton(
                            onPressed: () {},
                            height: screenHeight * 0.05,
                            width: screenWidth,
                            child: Text(
                              'My Record',
                              style: TextStyle(
                                fontFamily: fontStyle,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Information:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: fontStyle,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: greyLite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'First Name: ${info.firstName}\n\nLast Name: ${info.lastName}\n\nEmail: ${info.email}\n\nBirthday: ${info.birthday}\n\nCreate At: ${info.createAt}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SquareButton(
                            onPressed: () {},
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.07,
                            child: Text(
                              'Change Information',
                              style: TextStyle(fontFamily: fontStyle),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SquareButton(
                            onPressed: () {},
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.07,
                            child: Text(
                              'Change Password',
                              style: TextStyle(fontFamily: fontStyle),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is GetInfoFailed) {
            return Login(
              mode: true,
              userBloc: bloc,
            );
          }
          if (state is UserInitial) {
            bloc.add(GetUserInfo());
          }
          return Container();
        },
      ),
    );
  }
}
