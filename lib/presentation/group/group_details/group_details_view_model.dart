/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/group_model.dart';
import 'package:redux/redux.dart';

class GroupDetailsViewModel {
  final Group group;

  GroupDetailsViewModel({
    required this.group,
  });

  static GroupDetailsViewModel fromStore(Store<AppState> store) {
    return GroupDetailsViewModel(
      group: store.state.groupList?.first ?? Group(),
    );
  }
}
