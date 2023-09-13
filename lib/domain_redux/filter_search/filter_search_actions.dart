/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:passmana/model/group_model.dart';

class InitializeFilter {}

class ChangeSelectionOfGroup {
  final int groupId;

  ChangeSelectionOfGroup({required this.groupId});
}

class ChangeKeyword {
  final String searchKeyword;

  ChangeKeyword({required this.searchKeyword});
}

class SelectedGroupForFilterListChanged {
  final List<Map<Group, bool>> selectedGroupsForFilterList;

  SelectedGroupForFilterListChanged({
    required this.selectedGroupsForFilterList,
  });
}

class SearchKeywordChanged {
  final String searchKeyword;

  SearchKeywordChanged({required this.searchKeyword});
}
