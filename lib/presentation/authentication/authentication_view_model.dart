/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  final bool isBiometricEnabled;
  final Function(TextEditingController) verifyPin;
  final Function verifyBiometric;
  final Function(TextEditingController) onBackTap;

  AuthenticationViewModel({
    required this.isBiometricEnabled,
    required this.verifyBiometric,
    required this.verifyPin,
    required this.onBackTap,
  });

  static AuthenticationViewModel fromStore(Store<AppState> store) {
    return AuthenticationViewModel(
      isBiometricEnabled: store.state.user?.isBiometricEnabled ?? false,
      verifyBiometric: () {
        store.dispatch(
          VerifyUserBiometric(
            onVerified: () {
              router.go(AppRoutes.passwordList);
            },
            onNotVerified: () {
              //do nothing
            },
          ),
        );
      },
      verifyPin: (pinController) {
        store.dispatch(
          VerifyUserPin(
            pin: pinController.text,
            onVerified: () {
              pinController.clear();
              router.go(AppRoutes.passwordList);
            },
            onNotVerified: () {
              pinController.clear();
            },
          ),
        );
      },
      onBackTap: (TextEditingController pinController) {
        if (pinController.text.isNotEmpty) {
          pinController.text = pinController.text.substring(0, pinController.text.length - 1);
        } else {
          //do nothing
        }
      },
    );
  }
}
