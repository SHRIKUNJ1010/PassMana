/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passmana/presentation/authentication/authentication_screen.dart';
import 'package:passmana/presentation/get_started/get_started_screen.dart';
import 'package:passmana/presentation/group/group_list/group_list_screen.dart';
import 'package:passmana/presentation/navigation_bar_screen.dart';
import 'package:passmana/presentation/sign_up_flow/create_master_password/create_master_password_screen.dart';
import 'package:passmana/presentation/sign_up_flow/create_mobile_pin/create_mobile_pin_screen.dart';
import 'package:passmana/presentation/splash/splash_screen.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/page_routes_utility/page_routes_animation.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.splash,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const SplashScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.getStarted,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const GetStartedScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.authentication,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const AuthenticationScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.createMasterPassword,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const CreateMasterPasswordScreen(),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.createMobilePin,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const CreateMobilePinScreen(),
          key: state.pageKey,
        );
      },
    ),
    ShellRoute(
      parentNavigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return NavigationBarScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.passwordList,
          pageBuilder: (context, state) {
            return FadeTransitionPage(
              child: const CreateMobilePinScreen(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.groupList,
          pageBuilder: (context, state) {
            return FadeTransitionPage(
              child: const GroupListScreen(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.settings,
          pageBuilder: (context, state) {
            return FadeTransitionPage(
              child: const CreateMobilePinScreen(),
              key: state.pageKey,
            );
          },
        ),
      ],
    ),
  ],
);
