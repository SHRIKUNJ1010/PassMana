/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_actions.dart';
import 'package:passmana/model/group_model.dart';
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

  CreateUpdateGroupViewModel({
    this.group,
    required this.createGroup,
    required this.updateGroup,
  });

  static CreateUpdateGroupViewModel fromStore(Store<AppState> store) {
    return CreateUpdateGroupViewModel(
      //todo: change group by passing id or index and using selector
      group: store.state.groupList?.first,
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
      },
      updateGroup: ({
        required String groupName,
        required String description,
      }) {
        store.dispatch(
          UpdateGroup(
            //todo: change to selector as above
            group: store.state.groupList?.first.updateGroupInfo(
              groupName: groupName,
              description: description,
            ),
          ),
        );
      },
    );
  }
}