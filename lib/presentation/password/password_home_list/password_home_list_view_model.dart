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
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class PasswordHomeListViewModel {
  final Function getAllData;
  final List<Password> recentlyAddedPasswordList;
  final Function(int) onPasswordItemTap;
  final Function(String) onCopyPasswordTap;
  final List<Group> popularGroups;
  final Function(int) onGroupItemTap;
  final bool seeAllPasswords;
  final Function onSeeAllPasswordsTap;
  final bool seeAllGroups;
  final Function onSeeAllGroupsTap;
  final Function onGeneratePasswordTap;
  final Function onSearchPasswordTap;

  PasswordHomeListViewModel({
    required this.getAllData,
    required this.recentlyAddedPasswordList,
    required this.onPasswordItemTap,
    required this.onCopyPasswordTap,
    required this.popularGroups,
    required this.onGroupItemTap,
    required this.seeAllGroups,
    required this.onSeeAllGroupsTap,
    required this.seeAllPasswords,
    required this.onSeeAllPasswordsTap,
    required this.onGeneratePasswordTap,
    required this.onSearchPasswordTap,
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
      onPasswordItemTap: (id) {
        router.push(AppRoutes.passwordDetails, extra: id);
      },
      onCopyPasswordTap: (val) async {
        await Utility.copyToClipboard(val);
      },
      popularGroups: getPopularGroupList(store.state),
      onGroupItemTap: (id) {
        router.push(AppRoutes.groupDetails, extra: id);
      },
      onGeneratePasswordTap: () {
        router.push(AppRoutes.generatePassword);
      },
      onSearchPasswordTap: () {
        router.push(AppRoutes.filterSearch);
      },
    );
  }
}
