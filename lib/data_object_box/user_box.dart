/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/user_model.dart';
import 'package:passmana/utility/cryptography_utility/crypto_utility/crypto_utility.dart';

class UserBox {
  late final Box<User> _userBox;

  UserBox(Store store) {
    _userBox = Box<User>(store);
  }

  bool hasUser() {
    var users = _userBox.getAll();
    return users.isNotEmpty && users.first.pin != '';
  }

  Future<User?> getUser() async {
    if (_userBox.getAll().isEmpty) return null;
    User tempUser = _userBox.getAll().first;
    String tempUserPin = "";
    if (tempUser.pin != "") {
      tempUserPin = await CryptoUtility.decryptText(tempUser.pin);
    }
    return tempUser.setPin(tempUserPin);
  }

  Future<void> changeCreatePin(String pin) async {
    User? user = await getUser();
    if (user != null && pin == "") return;
    String tempPin = "";
    if (pin != "") {
      tempPin = await CryptoUtility.encryptText(pin);
    }
    await _userBox.putAsync(
      user != null ? user.setPin(tempPin) : User(pin: tempPin),
      mode: user != null ? PutMode.update : PutMode.insert,
    );
  }

  void changeBiometricOption(bool isBiometricEnabled) async {
    User? user = await getUser();
    if (user != null) {
      await _userBox.putAsync(
        user.changeBiometricOption(isBiometricEnabled),
        mode: PutMode.update,
      );
    }
  }

  void changeAutofillOption(bool isAutofillOption) async {
    User? user = await getUser();
    if (user != null) {
      await _userBox.putAsync(
        user.changeAutofillOption(isAutofillOption),
        mode: PutMode.update,
      );
    }
  }

  void changeLanguage(String localeString) async {
    User? user = await getUser();
    if (user != null) {
      await _userBox.putAsync(
        user.changeLanguage(localeString),
        mode: PutMode.update,
      );
    }
  }
}
