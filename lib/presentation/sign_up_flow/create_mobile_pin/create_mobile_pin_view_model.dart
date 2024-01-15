/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateMobilePinViewModel {
  final Function(String) onPinSave;
  final Function onBackTap;

  CreateMobilePinViewModel({
    required this.onPinSave,
    required this.onBackTap,
  });

  static CreateMobilePinViewModel fromStore(
    Store<AppState> store,
  ) {
    return CreateMobilePinViewModel(
      onPinSave: (pin) {
        store.dispatch(UpdatePin(pin: pin));
        router.go(AppRoutes.passwordHomeList);
      },
      onBackTap: () {
        router.pop();
      },
    );
  }
}
