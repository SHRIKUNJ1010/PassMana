/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class GroupListViewModel {
  final List<Group> groupList;
  final Function onBackPress;
  final Function(int) onGroupTileTap;

  GroupListViewModel({
    required this.groupList,
    required this.onBackPress,
    required this.onGroupTileTap,
  });

  static GroupListViewModel fromStore(Store<AppState> store) {
    return GroupListViewModel(
      groupList: getGroupList(store.state),
      onBackPress: () {
        router.pop();
      },
      onGroupTileTap: (id) {
        router.push(AppRoutes.groupDetails, extra: id);
      },
    );
  }
}
