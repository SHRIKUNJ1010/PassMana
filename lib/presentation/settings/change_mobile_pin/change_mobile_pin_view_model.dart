/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/domain_redux/user/user_selector.dart';
import 'package:passmana/router/router.dart';
import 'package:redux/redux.dart';

class ChangeMobilePinViewModel {
  final String oldPin;
  final Function(String) changePin;
  final Function onBackTap;

  ChangeMobilePinViewModel({
    required this.oldPin,
    required this.changePin,
    required this.onBackTap,
  });

  static ChangeMobilePinViewModel fromStore(Store<AppState> store) {
    return ChangeMobilePinViewModel(
      oldPin: getUserPin(store.state),
      changePin: (String pin) {
        store.dispatch(UpdatePin(pin: pin));
        router.pop();
      },
      onBackTap: () {
        router.pop();
      },
    );
  }
}
