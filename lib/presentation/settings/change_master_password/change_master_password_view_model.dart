/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:redux/redux.dart';

class ChangeMasterPasswordViewModel {
  final Function(String) checkMasterPassword;
  final Function(String) changeMasterPassword;

  ChangeMasterPasswordViewModel({
    required this.checkMasterPassword,
    required this.changeMasterPassword,
  });

  static ChangeMasterPasswordViewModel fromStore(Store<AppState> store) {
    return ChangeMasterPasswordViewModel(
      checkMasterPassword: (String password) {
        //todo: add validations
        //todo: check master password
      },
      changeMasterPassword: (String password) {
        //todo: add validations
        store.dispatch(UpdateMasterPassword(masterPassword: password));
        //todo: navigate back to settings screen
      },
    );
  }
}
