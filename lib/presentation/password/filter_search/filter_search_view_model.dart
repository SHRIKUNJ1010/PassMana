/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_actions.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class FilterSearchViewModel {
  final String searchKeyword;
  final List<Map<Group, bool>> selectedGroupsForFilterList;
  final List<Password> searchedPasswordList;
  final Function(int) onPasswordTileTap;
  final Function(String) onCopyTap;
  final Function(int) changeSelectionOfGroup;
  final Function(String) changeKeyword;
  final Function onBackPress;

  FilterSearchViewModel({
    required this.searchKeyword,
    required this.selectedGroupsForFilterList,
    required this.searchedPasswordList,
    required this.onPasswordTileTap,
    required this.onCopyTap,
    required this.changeSelectionOfGroup,
    required this.changeKeyword,
    required this.onBackPress,
  });

  static FilterSearchViewModel fromStore(Store<AppState> store) {
    return FilterSearchViewModel(
      searchKeyword: getSearchKeyword(store.state),
      selectedGroupsForFilterList: getSelectedGroupsForFilterList(store.state),
      searchedPasswordList: getSearchedPasswordList(store.state),
      //TODO: put filter for selection of group and filtering search results based on group too
      changeSelectionOfGroup: (int groupId) {
        store.dispatch(ChangeSelectionOfGroup(groupId: groupId));
      },
      changeKeyword: (String searchKeyword) {
        store.dispatch(ChangeKeyword(searchKeyword: searchKeyword));
      },
      onPasswordTileTap: (id) {
        router.push(AppRoutes.passwordDetails, extra: id);
      },
      onCopyTap: (val) async {
        await Utility.copyToClipboard(val);
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
