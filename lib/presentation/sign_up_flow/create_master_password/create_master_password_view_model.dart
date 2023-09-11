/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateMasterPasswordViewModel {
  final Function(String) onCreateTap;

  CreateMasterPasswordViewModel({
    required this.onCreateTap,
  });

  static CreateMasterPasswordViewModel fromStore(Store<AppState> store) {
    return CreateMasterPasswordViewModel(
      onCreateTap: (String password) {
        //todo: add validations
        store.dispatch(UpdateMasterPassword(masterPassword: password));
        router.go(AppRoutes.createMobilePin);
      },
    );
  }
}
