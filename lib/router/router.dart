/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passmana/presentation/splash_screen.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/page_routes_utility/page_routes_animation.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: splashScreenRoute,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const SplashScreen(),
          key: state.pageKey,
        );
      },
    ),
  ],
);
