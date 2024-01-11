/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateUpdateGroupViewModel {
  final Group? group;
  final Function({
    required String groupName,
    required String description,
  }) createGroup;
  final Function({
    required String groupName,
    required String description,
  }) updateGroup;
  final Function deleteGroup;
  final Function onBackPress;

  CreateUpdateGroupViewModel({
    this.group,
    required this.createGroup,
    required this.updateGroup,
    required this.deleteGroup,
    required this.onBackPress,
  });

  static CreateUpdateGroupViewModel fromStore(Store<AppState> store, int? id) {
    return CreateUpdateGroupViewModel(
      group: getGroupById(store.state, id),
      createGroup: ({
        required String groupName,
        required String description,
      }) {
        store.dispatch(
          CreateGroup(
            groupName: groupName,
            description: description,
          ),
        );
        router.pop();
      },
      updateGroup: ({
        required String groupName,
        required String description,
      }) {
        store.dispatch(
          UpdateGroup(
            group: getGroupById(store.state, id)?.updateGroupInfo(
                  groupName: groupName,
                  description: description,
                  lastUpdatedOn: DateTime.now(),
                ) ??
                Group(
                  createdOn: DateTime.now(),
                  lastUpdatedOn: DateTime.now(),
                ),
          ),
        );
        router.pop();
      },
      deleteGroup: () {
        //todo: confirmation dialog
        store.dispatch(DeleteGroup(groupId: id ?? 0));
        router.go(AppRoutes.passwordHomeList);
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
