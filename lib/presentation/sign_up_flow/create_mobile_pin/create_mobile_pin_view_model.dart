/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/model/user_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateMobilePinViewModel {
  final bool isConfirm;
  final Function(TextEditingController) onSubmitTap;
  final Function(TextEditingController) onBackTap;

  CreateMobilePinViewModel({
    required this.isConfirm,
    required this.onSubmitTap,
    required this.onBackTap,
  });

  static CreateMobilePinViewModel fromStore(
    Store<AppState> store,
  ) {
    return CreateMobilePinViewModel(
      //todo: use selector for accessing state do not directly access the state
      isConfirm: store.state.user?.pin != null && store.state.user?.pin != "",
      onSubmitTap: (TextEditingController pinController) {
        if (store.state.user?.pin == null || store.state.user?.pin == "") {
          store.dispatch(
            UserChanged(
              user: User(
                id: store.state.user?.id ?? 0,
                pin: pinController.text,
              ),
            ),
          );
          pinController.clear();
        } else {
          if (store.state.user?.pin == pinController.text) {
            store.dispatch(UpdatePin(pin: pinController.text));
            pinController.clear();
            router.go(AppRoutes.passwordList);
          } else {
            pinController.clear();
          }
        }
      },
      onBackTap: (TextEditingController pinController) {
        if (pinController.text.isNotEmpty) {
          pinController.text = pinController.text.substring(0, pinController.text.length - 1);
        } else {
          router.pop();
        }
      },
    );
  }
}
