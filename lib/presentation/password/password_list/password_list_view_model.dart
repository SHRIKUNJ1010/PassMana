/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

class PasswordListViewModel {
  final List<Password> passwordList;

  PasswordListViewModel({
    required this.passwordList,
  });

  static PasswordListViewModel fromStore(Store<AppState> store) {
    return PasswordListViewModel(
      passwordList: getPasswordList(store.state),
    );
  }
}
