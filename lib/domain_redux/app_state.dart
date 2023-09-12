/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/model/user_model.dart';

class AppState {
  final User? user;
  final List<Password>? passwordList;
  final List<Group>? groupList;

  AppState({
    this.user,
    this.passwordList,
    this.groupList,
  });

  AppState copyWith({
    User? user,
    List<Password>? passwordList,
    List<Group>? groupList,
  }) {
    return AppState(
      user: user ?? this.user,
      passwordList: passwordList ?? this.passwordList,
      groupList: groupList ?? this.groupList,
    );
  }

  @override
  int get hashCode => user.hashCode ^ passwordList.hashCode ^ groupList.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState && runtimeType == other.runtimeType && user == other.user && passwordList == other.passwordList && groupList == other.groupList;
  }
}
