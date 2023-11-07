/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

class PasswordDetailsViewModel {
  final Password password;

  PasswordDetailsViewModel({
    required this.password,
  });

  static PasswordDetailsViewModel fromStore(Store<AppState> store) {
    return PasswordDetailsViewModel(
      //todo: change using selector
      password: store.state.passwordList?.first ?? Password(),
    );
  }
}