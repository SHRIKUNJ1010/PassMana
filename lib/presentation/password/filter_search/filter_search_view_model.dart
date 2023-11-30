/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_actions.dart';
import 'package:passmana/model/group_model.dart';
import 'package:redux/redux.dart';

class FilterSearchViewModel {
  final String searchKeyword;
  final List<Map<Group, bool>> selectedGroupsForFilterList;
  final Function(int) changeSelectionOfGroup;
  final Function(String) changeKeyword;

  FilterSearchViewModel({
    required this.searchKeyword,
    required this.selectedGroupsForFilterList,
    required this.changeSelectionOfGroup,
    required this.changeKeyword,
  });

  static FilterSearchViewModel fromStore(Store<AppState> store) {
    return FilterSearchViewModel(
      //todo: use selector do not directly access the state
      searchKeyword: store.state.searchKeyword,
      //todo: use selector do not directly access the state
      selectedGroupsForFilterList: store.state.selectedGroupsForFilterList ?? [],
      changeSelectionOfGroup: (int groupId) {
        store.dispatch(ChangeSelectionOfGroup(groupId: groupId));
      },
      changeKeyword: (String searchKeyword) {
        store.dispatch(ChangeKeyword(searchKeyword: searchKeyword));
      },
    );
  }
}
