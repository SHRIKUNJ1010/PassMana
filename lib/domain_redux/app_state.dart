/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/object_box/user_box.dart';

class AppState {
  final User? user;

  AppState({
    this.user,
  });

  AppState copyWith({
    User? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }

  @override
  int get hashCode => user.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AppState && runtimeType == other.runtimeType && user == other.user;
  }
}
