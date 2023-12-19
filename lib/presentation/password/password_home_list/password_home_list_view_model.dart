/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

class PasswordHomeListViewModel {
  final List<Password> recentlyAddedPasswordList;
  final List<Group> popularGroups;

  PasswordHomeListViewModel({
    required this.recentlyAddedPasswordList,
    required this.popularGroups,
  });

  static PasswordHomeListViewModel fromStore(Store<AppState> store) {
    return PasswordHomeListViewModel(
      recentlyAddedPasswordList: getRecentlyAddedPasswordList(store.state),
      popularGroups: getPopularGroupList(store.state),
    );
  }
}
