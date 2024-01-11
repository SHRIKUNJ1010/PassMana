/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/group_model.dart';

Group getGroupByIndex(AppState state, int index) => state.groupList![index];

Group? getGroupById(AppState state, int? groupId) {
  Group? tempGroup;
  try {
    tempGroup = groupId == null ? null : state.groupList?.singleWhere((element) => element.id == groupId);
  } catch (e) {
    tempGroup = null;
  }
  return tempGroup;
}

List<Group> getGroupList(AppState state) {
  return state.groupList ?? [];
}

List<Group> getPopularGroupList(AppState state) {
  return state.popularGroupList ?? [];
}
