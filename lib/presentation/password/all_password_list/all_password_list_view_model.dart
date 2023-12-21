/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/router/router.dart';
import 'package:redux/redux.dart';

class AllPasswordListViewModel {
  final List<Password> passwordList;
  final Function onBackPress;

  AllPasswordListViewModel({
    required this.passwordList,
    required this.onBackPress,
  });

  static AllPasswordListViewModel fromStore(Store<AppState> store) {
    return AllPasswordListViewModel(
      passwordList: getPasswordList(store.state),
      onBackPress: () {
        router.pop();
      },
    );
  }
}
