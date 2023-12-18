/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passmana/presentation/authentication/authentication_screen.dart';
import 'package:passmana/presentation/card/card_list/card_list_screen.dart';
import 'package:passmana/presentation/create_list/create_list_screen.dart';
import 'package:passmana/presentation/get_started/get_started_screen.dart';
import 'package:passmana/presentation/group/create_update_group/create_update_group_screen.dart';
import 'package:passmana/presentation/group/group_details/group_details_screen.dart';
import 'package:passmana/presentation/navigation_bar/navigation_bar_screen.dart';
import 'package:passmana/presentation/password/create_update_password/create_update_password_screen.dart';
import 'package:passmana/presentation/password/password_details/password_details_screen.dart';
import 'package:passmana/presentation/password/password_list/password_list_screen.dart';
import 'package:passmana/presentation/secret_note/secret_note_list/secret_note_list_screen.dart';
import 'package:passmana/presentation/settings/change_mobile_pin/change_mobile_pin_screen.dart';
import 'package:passmana/presentation/settings/settings_item_list/settings_item_list_screen.dart';
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
      path: AppRoutes.createMobilePin,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const CreateMobilePinScreen(),
          key: state.pageKey,
        );
      },
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return NavigationBarScreen(
          child: child,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.passwordList,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const PasswordListScreen(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.cardList,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const CardListScreen(),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.secretNoteList,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const SecretNoteListScreen(),
              key: state.pageKey,
            );
          },
        ),
        /*GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.groupList,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const GroupListScreen(),
              key: state.pageKey,
            );
          },
        ),*/
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.createList,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const CreateListScreen(),
              key: state.pageKey,
            );
          },
        ),
        /*GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.generatePassword,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const GeneratePasswordScreen(),
              key: state.pageKey,
            );
          },
        ),*/
        GoRoute(
          parentNavigatorKey: shellNavigatorKey,
          path: AppRoutes.settings,
          pageBuilder: (context, state) {
            return SlideLeftTransitionPage(
              child: const SettingsItemListScreen(),
              key: state.pageKey,
            );
          },
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.createUpdateGroup,
      pageBuilder: (context, state) {
        int tempId = state.extra as int;
        return FadeTransitionPage(
          child: CreateUpdateGroupScreen(id: tempId),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.groupDetails,
      pageBuilder: (context, state) {
        int tempId = state.extra as int;
        return FadeTransitionPage(
          child: GroupDetailsScreen(id: tempId),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.createUpdatePassword,
      pageBuilder: (context, state) {
        int tempId = state.extra as int;
        return FadeTransitionPage(
          child: CreateUpdatePasswordScreen(id: tempId),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.passwordDetails,
      pageBuilder: (context, state) {
        int tempId = state.extra as int;
        return FadeTransitionPage(
          child: PasswordDetailsScreen(id: tempId),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutes.changeMobilePin,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const ChangeMobilePinScreen(),
          key: state.pageKey,
        );
      },
    ),
  ],
);
