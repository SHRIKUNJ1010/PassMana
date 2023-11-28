/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/user_model.dart';

class UserBox {
  late final Box<User> _userBox;

  UserBox(Store store) {
    _userBox = Box<User>(store);
  }

  bool hasUser() {
    var users = _userBox.getAll();
    return users.isNotEmpty && users.first.pin != '';
  }

  User? getUser() {
    return _userBox.getAll().isEmpty ? null : _userBox.getAll().first;
  }

  void changeCreatePin(String pin) {
    User? user = getUser();
    if (user != null && pin == "") return;
    _userBox.put(
      user != null ? user.setPin(pin) : User(pin: pin),
      mode: user != null ? PutMode.update : PutMode.insert,
    );
  }

  void changeBiometricOption(bool isBiometricEnabled) {
    User? user = getUser();
    if (user != null) {
      _userBox.put(
        user.changeBiometricOption(isBiometricEnabled),
        mode: PutMode.update,
      );
    }
  }
}
