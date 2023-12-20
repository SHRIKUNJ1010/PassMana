/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/card/card_actions.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/domain_redux/secret_note/secret_note_actions.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

class PasswordHomeListViewModel {
  final Function getAllData;
  final List<Password> recentlyAddedPasswordList;
  final List<Group> popularGroups;

  PasswordHomeListViewModel({
    required this.getAllData,
    required this.recentlyAddedPasswordList,
    required this.popularGroups,
  });

  static PasswordHomeListViewModel fromStore(Store<AppState> store) {
    return PasswordHomeListViewModel(
      getAllData: () {
        store.dispatch(GetAllPasswords());
        store.dispatch(GetAllGroups());
        store.dispatch(GetAllCards());
        store.dispatch(GetAllSecretNotes());
      },
      recentlyAddedPasswordList: getRecentlyAddedPasswordList(store.state),
      popularGroups: getPopularGroupList(store.state),
    );
  }
}
