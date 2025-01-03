/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/domain_redux/user/user_selector.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  final bool isBiometricEnabled;
  final Function({required TextEditingController pinController, required Function(String) errorCallBack}) verifyPin;
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
      isBiometricEnabled: getIsBiometricEnabled(store.state),
      verifyBiometric: () {
        store.dispatch(VerifyUserBiometric());
      },
      verifyPin: ({required TextEditingController pinController, required Function(String) errorCallBack}) {
        store.dispatch(VerifyUserPin(
          pin: pinController.text,
          errorCallBack: errorCallBack,
        ));
        pinController.clear();
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
