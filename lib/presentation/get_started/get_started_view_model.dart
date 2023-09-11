/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class GetStartedViewModel {
  final Function onGetStartedPressed;

  GetStartedViewModel({required this.onGetStartedPressed});

  static GetStartedViewModel fromStore(Store<AppState> store) {
    return GetStartedViewModel(
      onGetStartedPressed: () {
        store.dispatch(CreateUser(masterPassword: '', pin: ''));
        router.go(AppRoutes.createMasterPassword);
      },
    );
  }
}
