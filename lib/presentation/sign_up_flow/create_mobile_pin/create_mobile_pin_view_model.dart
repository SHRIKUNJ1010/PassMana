/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/domain_redux/user/user_selector.dart';
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
      isConfirm: getIsConfirmPin(store.state),
      onSubmitTap: (TextEditingController pinController) {
        // if is not confirm pin which invert of is confirm pin
        // for is confirm pin state of user is changed for pin but
        // database of user is not changed
        if (!getIsConfirmPin(store.state)) {
          store.dispatch(
            //this action is part of reducer which changes state
            UserChanged(
              user: User(
                id: getUserId(store.state),
                pin: pinController.text,
              ),
            ),
          );
          pinController.clear();
        } else {
          //for first user pin input add pin in app state but do not change object box database
          if (getUserPin(store.state) == pinController.text) {
            store.dispatch(UpdatePin(pin: pinController.text));
            pinController.clear();
            router.go(AppRoutes.passwordHomeList);
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
