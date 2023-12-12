/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'dart:ui';

import 'package:passmana/model/card_model.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/model/user_model.dart';
import 'package:passmana/utility/constants.dart';

class AppState {
  final User? user;
  final List<Password>? passwordList;
  final List<Group>? groupList;
  final List<Card>? cardList;
  final List<SecretNote>? secretNoteList;
  final List<Map<Group, bool>>? selectedGroupsForFilterList;
  final String searchKeyword;
  final Locale locale;

  AppState({
    this.user,
    this.passwordList,
    this.groupList,
    this.cardList,
    this.secretNoteList,
    this.selectedGroupsForFilterList,
    this.searchKeyword = '',
    this.locale = const Locale(AppConstants.english),
  });

  AppState copyWith({
    User? user,
    List<Password>? passwordList,
    List<Group>? groupList,
    List<Card>? cardList,
    List<SecretNote>? secretNoteList,
    List<Map<Group, bool>>? selectedGroupsForFilterList,
    String? searchKeyword,
    Locale? locale,
  }) {
    return AppState(
      user: user ?? this.user,
      passwordList: passwordList ?? this.passwordList,
      groupList: groupList ?? this.groupList,
      cardList: cardList ?? this.cardList,
      secretNoteList: secretNoteList ?? this.secretNoteList,
      selectedGroupsForFilterList: selectedGroupsForFilterList ?? this.selectedGroupsForFilterList,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      locale: locale ?? this.locale,
    );
  }

  @override
  int get hashCode =>
      user.hashCode ^
      passwordList.hashCode ^
      groupList.hashCode ^
      cardList.hashCode ^
      secretNoteList.hashCode ^
      searchKeyword.hashCode ^
      selectedGroupsForFilterList.hashCode ^
      locale.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            user == other.user &&
            passwordList == other.passwordList &&
            groupList == other.groupList &&
            cardList == other.cardList &&
            secretNoteList == other.secretNoteList &&
            searchKeyword == other.searchKeyword &&
            selectedGroupsForFilterList == other.selectedGroupsForFilterList &&
            locale == other.locale;
  }
}
