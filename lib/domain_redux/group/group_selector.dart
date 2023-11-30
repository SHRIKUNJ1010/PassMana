/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/group_model.dart';

Group getGroupByIndex(AppState state, int index) => state.groupList![index];

Group? getGroupById(AppState state, int groupId) => state.groupList?.singleWhere((element) => element.id == groupId);

List<Group> getGroupList(AppState state) {
  return state.groupList ?? [];
}