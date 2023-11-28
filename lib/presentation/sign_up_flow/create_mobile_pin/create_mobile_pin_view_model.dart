/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateMobilePinViewModel {
  final Function(TextEditingController) onSubmitTap;
  final Function(TextEditingController) onBackTap;

  CreateMobilePinViewModel({
    required this.onSubmitTap,
    required this.onBackTap,
  });

  static CreateMobilePinViewModel fromStore(
    Store<AppState> store,
  ) {
    return CreateMobilePinViewModel(
      onSubmitTap: (TextEditingController pinController) {
        store.dispatch(UpdatePin(pin: pinController.text));
        pinController.clear();
        router.go(AppRoutes.passwordList);
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
