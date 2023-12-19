/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:passmana/model/password_model.dart';
import 'package:passmana/objectbox.g.dart';

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
        createdDate: DateTime.now(),
      ),
      mode: PutMode.insert,
    );
  }

  updatePassword({
    required Password password,
  }) {
    _passwordBox.put(
      password,
      mode: PutMode.update,
    );
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

  List<Password> getRecentlyAddedPasswords() {
    //build query password based on created date in descending order
    final Query<Password> query = (_passwordBox.query()..order(Password_.createdDate, flags: Order.descending)).build();
    //limit query for the count of 10
    query.limit = 10;
    //use query to get 10 recently added passwords
    List<Password> tempList = query.find();
    return tempList;
  }
}
