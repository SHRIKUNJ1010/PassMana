/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/router/router.dart';
import 'package:redux/redux.dart';

class PasswordDetailsViewModel {
  final Password password;
  final List<Group> groupList;
  final Function onBackPress;

  PasswordDetailsViewModel({
    required this.password,
    required this.groupList,
    required this.onBackPress,
  });

  static PasswordDetailsViewModel fromStore(Store<AppState> store, int id) {
    return PasswordDetailsViewModel(
      password: getPasswordById(store.state, id) ?? Password(createdDate: DateTime.now()),
      groupList: getGroupList(store.state),
      onBackPress: () {
        router.pop();
      },
    );
  }
}
