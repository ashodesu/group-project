import 'package:asm/app/core/bloc/database_bloc/database_bloc.dart';
import 'package:asm/app/ui/regist.dart';
import 'package:asm/app/ui/sub/change_info/change_info.dart';
import 'package:asm/app/ui/login.dart';
import 'package:asm/app/ui/main/main.dart';
import 'package:asm/app/ui/sub/database_details/details.dart';
import 'package:asm/app/ui/sub/submit_record/submit_record.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter extends StatelessWidget {
  AppRouter({
    Key? key,
  })  : _router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Login(),
              routes: [
                GoRoute(
                  path: 'home',
                  builder: (context, state) => MainPage(defaultBody: 'home'),
                  routes: [
                    GoRoute(
                      path: 'submit',
                      builder: (context, state) => SubmitRecord(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'regist',
                  builder: (context, state) => RegistPage(),
                ),
              ],
            ),
          ],
        ),
        super(key: key);
  final GoRouter _router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}
