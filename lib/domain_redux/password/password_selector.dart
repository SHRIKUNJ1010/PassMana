/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/password_model.dart';

Password getPasswordByIndex(AppState state, int index) => state.passwordList![index];

Password? getPasswordById(AppState state, int? passwordId) => state.passwordList?.singleWhere((element) => element.id == passwordId);

List<Password> getPasswordList(AppState state) {
  return state.passwordList ?? [];
}

List<Password> getRecentlyAddedPasswordList(AppState state) {
  return state.recentlyAddedPasswordList ?? [];
}

List<Password> getFilteredPasswordList(AppState state) {
  List<Password> tempList = [];
  if (state.passwordList != null) {
    for (var element in state.passwordList!) {
      //check if element title contains search keyword
      bool keywordCheck = element.title.contains(state.searchKeyword);
      //check if element group target is selected or not
      bool groupCheck = element.group.target == null
          ? true
          : state.selectedGroupsForFilterList != null
              ? state.selectedGroupsForFilterList!.singleWhere((e) => e.keys.single == element.group.target)[element.group.target] ?? false
              : false;
      // if keyword condition and group condition gets satisfied then add to display list
      if (keywordCheck && groupCheck) {
        tempList.add(element);
      }
    }
  }
  return tempList;
}
