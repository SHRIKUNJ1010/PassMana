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
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class PasswordHomeListViewModel {
  final Function getAllData;
  final List<Password> recentlyAddedPasswordList;
  final List<Group> popularGroups;
  final bool seeAllPasswords;
  final Function onSeeAllPasswordsTap;
  final bool seeAllGroups;
  final Function onSeeAllGroupsTap;

  PasswordHomeListViewModel({
    required this.getAllData,
    required this.recentlyAddedPasswordList,
    required this.popularGroups,
    required this.seeAllGroups,
    required this.onSeeAllGroupsTap,
    required this.seeAllPasswords,
    required this.onSeeAllPasswordsTap,
  });

  static PasswordHomeListViewModel fromStore(Store<AppState> store) {
    return PasswordHomeListViewModel(
      getAllData: () {
        store.dispatch(GetAllPasswords());
        store.dispatch(GetAllGroups());
        store.dispatch(GetAllCards());
        store.dispatch(GetAllSecretNotes());
      },
      seeAllGroups: getGroupList(store.state).length > 4,
      onSeeAllGroupsTap: () {
        router.push(AppRoutes.groupList);
      },
      seeAllPasswords: getPasswordList(store.state).length > 10,
      onSeeAllPasswordsTap: () {
        router.push(AppRoutes.allPasswordList);
      },
      recentlyAddedPasswordList: getRecentlyAddedPasswordList(store.state),
      popularGroups: getPopularGroupList(store.state),
    );
  }
}
