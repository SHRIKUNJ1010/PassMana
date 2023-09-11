/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:objectbox/objectbox.dart';
import 'package:passmana/model/password_model.dart';

class PasswordBox {
  late final Box<Password> _passwordBox;

  PasswordBox(Store store) {
    _passwordBox = Box<Password>(store);
  }

  addPassword({
    String title = '',
    String subTitle = '',
    String userName = '',
    String password = '',
    String note = '',
  }) {
    _passwordBox.put(
      Password(
        title: title,
        subTitle: subTitle,
        userName: userName,
        password: password,
        note: note,
      ),
    );
  }

  updatePassword({required Password password}) {
    _passwordBox.put(password);
  }

  List<Password> getAllPasswords() {
    return _passwordBox.getAll();
  }

  Password? getOnePassword(int passwordId) {
    return _passwordBox.get(passwordId);
  }

  deletePassword(int passwordId) {
    _passwordBox.remove(passwordId);
  }
}
