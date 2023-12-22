/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/router/router.dart';
import 'package:redux/redux.dart';

class GroupDetailsViewModel {
  final Group group;
  final Function onBackPress;

  GroupDetailsViewModel({
    required this.group,
    required this.onBackPress,
  });

  static GroupDetailsViewModel fromStore(Store<AppState> store, int id) {
    return GroupDetailsViewModel(
      group: getGroupById(store.state, id) ?? Group(),
      onBackPress: () {
        router.pop();
      },
    );
  }
}
