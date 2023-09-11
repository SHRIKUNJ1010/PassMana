/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:redux/redux.dart';

class CreateMobilePinViewModel {
  final Function(String) onCreateTap;

  CreateMobilePinViewModel({
    required this.onCreateTap,
  });

  static CreateMobilePinViewModel fromStore(Store<AppState> store) {
    return CreateMobilePinViewModel(
      onCreateTap: (String pin) {
        //todo: add validations
        store.dispatch(UpdatePin(pin: pin));
        //todo: navigate to home screen
      },
    );
  }
}
