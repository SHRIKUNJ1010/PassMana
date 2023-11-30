/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/group_model.dart';

String getSearchKeyword(AppState state) => state.searchKeyword;

List<Map<Group, bool>> getSelectedGroupsForFilterList(AppState state) => state.selectedGroupsForFilterList ?? [];