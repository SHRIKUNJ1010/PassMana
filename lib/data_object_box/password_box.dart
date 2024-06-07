/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:passmana/model/group_model.dart';
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
    String websiteUrl = '',
    String userName = '',
    String password = '',
    String note = '',
    String dynamicDataField = '{}',
    Group? targetGroup,
  }) {
    final tempPassword = Password(
      title: title,
      subTitle: subTitle,
      websiteUrl: websiteUrl,
      userName: userName,
      password: password,
      note: note,
      dynamicDataField: dynamicDataField,
      createdOn: DateTime.now(),
      lastUpdatedOn: DateTime.now(),
    );
    tempPassword.group.target = targetGroup;
    _passwordBox.put(
      tempPassword,
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

  List<Password> getAllPasswordsWithRecentlyCreatedFirst() {
    //build query password based on created date in descending order
    final Query<Password> query = (_passwordBox.query()..order(Password_.createdOn, flags: Order.descending)).build();
    List<Password> tempList = query.find();
    return tempList;
  }

  addAllPasswords(List<Password> tempPasswords) {
    _passwordBox.putMany(tempPasswords);
  }

  Password? getOnePassword(int passwordId) {
    return _passwordBox.get(passwordId);
  }

  deletePassword(int passwordId) {
    _passwordBox.remove(passwordId);
  }

  List<Password> getRecentlyAddedPasswords() {
    //build query password based on created date in descending order
    final Query<Password> query = (_passwordBox.query()..order(Password_.createdOn, flags: Order.descending)).build();
    //limit query for the count of 10
    query.limit = 10;
    //use query to get 10 recently added passwords
    List<Password> tempList = query.find();
    return tempList;
  }

  List<Password> getPasswordBasedOnKeyword(String keyword) {
    final Query<Password> query = (_passwordBox.query(Password_.title
            .contains(keyword)
            .or(Password_.subTitle.contains(keyword))
            .or(Password_.userName.contains(keyword))
            .or(Password_.websiteUrl.contains(keyword))
            .or(Password_.note.contains(keyword)))
          ..order(Password_.createdOn, flags: Order.descending))
        .build();

    List<Password> tempList = query.find();
    return tempList;
  }

  assignPasswordToGroup(Password password, Group group) {
    password.group.target = group;
    _passwordBox.put(
      password,
      mode: PutMode.update,
    );
  }
}
