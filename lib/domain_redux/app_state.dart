/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/model/card_model.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/model/secret_note_model.dart';
import 'package:passmana/model/user_model.dart';

class AppState {
  final User? user;
  final List<Password>? passwordList;
  final List<Password>? recentlyAddedPasswordList;
  final List<Group>? groupList;
  final List<Group>? popularGroupList;
  final List<Card>? cardList;
  final List<SecretNote>? secretNoteList;
  final List<Map<Group, bool>>? selectedGroupsForFilterList;
  final String searchKeyword;

  AppState({
    this.user,
    this.recentlyAddedPasswordList,
    this.passwordList,
    this.groupList,
    this.popularGroupList,
    this.cardList,
    this.secretNoteList,
    this.selectedGroupsForFilterList,
    this.searchKeyword = '',
  });

  AppState copyWith({
    User? user,
    List<Password>? recentlyAddedPasswordList,
    List<Password>? passwordList,
    List<Group>? groupList,
    List<Group>? popularGroupList,
    List<Card>? cardList,
    List<SecretNote>? secretNoteList,
    List<Map<Group, bool>>? selectedGroupsForFilterList,
    String? searchKeyword,
  }) {
    return AppState(
      user: user ?? this.user,
      recentlyAddedPasswordList: recentlyAddedPasswordList ?? this.recentlyAddedPasswordList,
      passwordList: passwordList ?? this.passwordList,
      groupList: groupList ?? this.groupList,
      popularGroupList: popularGroupList ?? this.popularGroupList,
      cardList: cardList ?? this.cardList,
      secretNoteList: secretNoteList ?? this.secretNoteList,
      selectedGroupsForFilterList: selectedGroupsForFilterList ?? this.selectedGroupsForFilterList,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }

  @override
  int get hashCode =>
      user.hashCode ^
      passwordList.hashCode ^
      recentlyAddedPasswordList.hashCode ^
      groupList.hashCode ^
      popularGroupList.hashCode ^
      cardList.hashCode ^
      secretNoteList.hashCode ^
      searchKeyword.hashCode ^
      selectedGroupsForFilterList.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            user == other.user &&
            recentlyAddedPasswordList == other.recentlyAddedPasswordList &&
            passwordList == other.passwordList &&
            groupList == other.groupList &&
            popularGroupList == other.popularGroupList &&
            cardList == other.cardList &&
            secretNoteList == other.secretNoteList &&
            searchKeyword == other.searchKeyword &&
            selectedGroupsForFilterList == other.selectedGroupsForFilterList;
  }
}
