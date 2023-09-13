/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'dart:ui';

import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/model/user_model.dart';
import 'package:passmana/utility/constants.dart';

class AppState {
  final User? user;
  final List<Password>? passwordList;
  final List<Group>? groupList;
  final List<Map<Group, bool>>? selectedGroupsForFilterList;
  final String searchKeyword;
  final Locale locale;

  AppState({
    this.user,
    this.passwordList,
    this.groupList,
    this.selectedGroupsForFilterList,
    this.searchKeyword = '',
    this.locale = const Locale(AppConstants.english),
  });

  AppState copyWith({
    User? user,
    List<Password>? passwordList,
    List<Group>? groupList,
    List<Map<Group, bool>>? selectedGroupsForFilterList,
    String? searchKeyword,
    Locale? locale,
  }) {
    return AppState(
      user: user ?? this.user,
      passwordList: passwordList ?? this.passwordList,
      groupList: groupList ?? this.groupList,
      selectedGroupsForFilterList: selectedGroupsForFilterList ?? this.selectedGroupsForFilterList,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      locale: locale ?? this.locale,
    );
  }

  @override
  int get hashCode =>
      user.hashCode ^ passwordList.hashCode ^ groupList.hashCode ^ searchKeyword.hashCode ^ selectedGroupsForFilterList.hashCode ^ locale.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            user == other.user &&
            passwordList == other.passwordList &&
            groupList == other.groupList &&
            searchKeyword == other.searchKeyword &&
            selectedGroupsForFilterList == other.selectedGroupsForFilterList &&
            locale == other.locale;
  }
}
