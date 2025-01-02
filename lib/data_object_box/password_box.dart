/*
* Created by Shrikunj Patel on 9/4/2023.
*/

import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/objectbox.g.dart';
import 'package:passmana/utility/cryptography_utility/crypto_utility/crypto_utility.dart';

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
  }) async {
    String tempTitle = await CryptoUtility.encryptText(title);
    String tempSubTitle = await CryptoUtility.encryptText(subTitle);
    String tempWebsiteUrl = await CryptoUtility.encryptText(websiteUrl);
    String tempUserName = await CryptoUtility.encryptText(userName);
    String tempPassword = await CryptoUtility.encryptText(password);
    String tempNote = await CryptoUtility.encryptText(note);
    String tempDynamicDataField = await CryptoUtility.encryptText(dynamicDataField);

    final tempPasswordModel = Password(
      title: tempTitle,
      subTitle: tempSubTitle,
      websiteUrl: tempWebsiteUrl,
      userName: tempUserName,
      password: tempPassword,
      note: tempNote,
      dynamicDataField: tempDynamicDataField,
      createdOn: DateTime.now(),
      lastUpdatedOn: DateTime.now(),
    );
    tempPasswordModel.group.target = targetGroup;
    await _passwordBox.putAsync(
      tempPasswordModel,
      mode: PutMode.insert,
    );
  }

  updatePassword({
    required int id,
    String title = '',
    String subTitle = '',
    String websiteUrl = '',
    String userName = '',
    String password = '',
    String note = '',
    String dynamicDataField = '{}',
    Group? targetGroup,
  }) async {
    String tempTitle = await CryptoUtility.encryptText(title);
    String tempSubTitle = await CryptoUtility.encryptText(subTitle);
    String tempWebsiteUrl = await CryptoUtility.encryptText(websiteUrl);
    String tempUserName = await CryptoUtility.encryptText(userName);
    String tempPassword = await CryptoUtility.encryptText(password);
    String tempNote = await CryptoUtility.encryptText(note);
    String tempDynamicDataField = await CryptoUtility.encryptText(dynamicDataField);

    final Password tempPasswordModel = (await getOnePassword(id) ??
            Password(
              id: id,
              createdOn: DateTime.now(),
              lastUpdatedOn: DateTime.now(),
            ))
        .updatePassword(
      title: tempTitle,
      subTitle: tempSubTitle,
      websiteUrl: tempWebsiteUrl,
      userName: tempUserName,
      password: tempPassword,
      note: tempNote,
      dynamicDataField: tempDynamicDataField,
      lastUpdatedOn: DateTime.now(),
    );

    tempPasswordModel.group.target = targetGroup;
    await _passwordBox.putAsync(
      tempPasswordModel,
      mode: PutMode.update,
    );
  }

  Future<List<Password>> getAllPasswords() async {
    List<Password> tempPasswords = [];

    for (Password element in _passwordBox.getAll()) {
      String tempTitle = await CryptoUtility.decryptText(element.title);
      String tempSubTitle = await CryptoUtility.decryptText(element.subTitle);
      String tempWebsiteUrl = await CryptoUtility.decryptText(element.websiteUrl);
      String tempUserName = await CryptoUtility.decryptText(element.userName);
      String tempPassword = await CryptoUtility.decryptText(element.password);
      String tempNote = await CryptoUtility.decryptText(element.note);
      String tempDynamicDataField = await CryptoUtility.decryptText(element.dynamicDataField);
      tempPasswords.add(
        element.updatePassword(
          title: tempTitle,
          subTitle: tempSubTitle,
          websiteUrl: tempWebsiteUrl,
          userName: tempUserName,
          password: tempPassword,
          note: tempNote,
          dynamicDataField: tempDynamicDataField,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempPasswords;
  }

  Future<List<Password>> getAllPasswordsWithRecentlyCreatedFirst() async {
    //build query password based on created date in descending order
    final Query<Password> query = (_passwordBox.query()..order(Password_.createdOn, flags: Order.descending)).build();
    List<Password> tempList = query.find();
    List<Password> tempPasswords = [];

    for (Password element in tempList) {
      String tempTitle = await CryptoUtility.decryptText(element.title);
      String tempSubTitle = await CryptoUtility.decryptText(element.subTitle);
      String tempWebsiteUrl = await CryptoUtility.decryptText(element.websiteUrl);
      String tempUserName = await CryptoUtility.decryptText(element.userName);
      String tempPassword = await CryptoUtility.decryptText(element.password);
      String tempNote = await CryptoUtility.decryptText(element.note);
      String tempDynamicDataField = await CryptoUtility.decryptText(element.dynamicDataField);
      tempPasswords.add(
        element.updatePassword(
          title: tempTitle,
          subTitle: tempSubTitle,
          websiteUrl: tempWebsiteUrl,
          userName: tempUserName,
          password: tempPassword,
          note: tempNote,
          dynamicDataField: tempDynamicDataField,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempPasswords;
  }

  addAllPasswords(List<Password> tempPasswords) {
    //todo: check this for import/export data option
    _passwordBox.putMany(tempPasswords);
  }

  Future<Password?> getOnePassword(int passwordId) async {
    Password tempPasswordValue = _passwordBox.get(passwordId) ??
        Password(
          id: passwordId,
          createdOn: DateTime.now(),
          lastUpdatedOn: DateTime.now(),
        );
    String tempTitle = await CryptoUtility.decryptText(tempPasswordValue.title);
    String tempSubTitle = await CryptoUtility.decryptText(tempPasswordValue.subTitle);
    String tempWebsiteUrl = await CryptoUtility.decryptText(tempPasswordValue.websiteUrl);
    String tempUserName = await CryptoUtility.decryptText(tempPasswordValue.userName);
    String tempPassword = await CryptoUtility.decryptText(tempPasswordValue.password);
    String tempNote = await CryptoUtility.decryptText(tempPasswordValue.note);
    String tempDynamicDataField = await CryptoUtility.decryptText(tempPasswordValue.dynamicDataField);

    return tempPasswordValue.updatePassword(
      title: tempTitle,
      subTitle: tempSubTitle,
      websiteUrl: tempWebsiteUrl,
      userName: tempUserName,
      password: tempPassword,
      note: tempNote,
      dynamicDataField: tempDynamicDataField,
      lastUpdatedOn: tempPasswordValue.lastUpdatedOn,
    );
  }

  deletePassword(int passwordId) async {
    await _passwordBox.removeAsync(passwordId);
  }

  Future<List<Password>> getRecentlyAddedPasswords() async {
    //build query password based on created date in descending order
    final Query<Password> query = (_passwordBox.query()..order(Password_.createdOn, flags: Order.descending)).build();
    //limit query for the count of 10
    query.limit = 10;
    //use query to get 10 recently added passwords
    List<Password> tempList = query.find();
    List<Password> tempPasswords = [];

    for (Password element in tempList) {
      String tempTitle = await CryptoUtility.decryptText(element.title);
      String tempSubTitle = await CryptoUtility.decryptText(element.subTitle);
      String tempWebsiteUrl = await CryptoUtility.decryptText(element.websiteUrl);
      String tempUserName = await CryptoUtility.decryptText(element.userName);
      String tempPassword = await CryptoUtility.decryptText(element.password);
      String tempNote = await CryptoUtility.decryptText(element.note);
      String tempDynamicDataField = await CryptoUtility.decryptText(element.dynamicDataField);
      tempPasswords.add(
        element.updatePassword(
          title: tempTitle,
          subTitle: tempSubTitle,
          websiteUrl: tempWebsiteUrl,
          userName: tempUserName,
          password: tempPassword,
          note: tempNote,
          dynamicDataField: tempDynamicDataField,
          lastUpdatedOn: element.lastUpdatedOn,
        ),
      );
    }
    return tempPasswords;
  }

  List<Password> getPasswordBasedOnKeyword(String keyword) {
    //TODO: this query will not work due to encryption/decryption please find another way
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
