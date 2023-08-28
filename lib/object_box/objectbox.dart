/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/object_box/user_box.dart';
import 'package:passmana/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

//provides the access to the object box store throughout the app
class ObjectBox {
  late final Store store;
  late final Box<User> userBox;

  ObjectBox._create(this.store) {
    userBox = Box<User>(store);
  }

  //create an instance of ObjectBox to use throughout the app
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    //pass the directory path to create database file in application folder and passmana subfolder
    //open store function is defined in objectbox.g.dart file
    final store = await openStore(directory: p.join(docsDir.path, "passmana"));
    return ObjectBox._create(store);
  }

  bool hasUser() {
    var users = userBox.getAll();
    return users.isNotEmpty && users.first.pin != '' && users.first.masterPassword != '';
  }

  User getUser() {
    return userBox.getAll().first;
  }

  void changeCreateMasterPassword(String masterPassword) {
    User user = getUser();
    userBox.put(user.setMasterPassword(masterPassword));
  }

  void changeCreatePin(String pin) {
    User user = getUser();
    userBox.put(user.setPin(pin));
  }
}
