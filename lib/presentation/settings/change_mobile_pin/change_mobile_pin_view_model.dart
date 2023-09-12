/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:redux/redux.dart';

class ChangeMobilePinViewModel {
  final Function(String) checkPin;
  final Function(String) changePin;

  ChangeMobilePinViewModel({
    required this.checkPin,
    required this.changePin,
  });

  static ChangeMobilePinViewModel fromStore(Store<AppState> store) {
    return ChangeMobilePinViewModel(
      changePin: (String pin) {
        //todo: add validations
        store.dispatch(UpdatePin(pin: pin));
        //todo: navigate back to settings screen
      },
      checkPin: (String pin) {
        //todo: add validations
        //todo: check pin
      },
    );
  }
}
