/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/group_model.dart';
import 'package:redux/redux.dart';

class GroupListViewModel {
  final List<Group> groupList;

  GroupListViewModel({required this.groupList});

  static GroupListViewModel fromStore(Store<AppState> store) {
    //todo: use selector for getting group list
    return GroupListViewModel(groupList: []);
  }
}
