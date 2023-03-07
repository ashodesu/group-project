import 'package:asm/app/landing.dart';
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
              builder: (context, state) => Landing(),
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
