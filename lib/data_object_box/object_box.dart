/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/data_object_box/group_box.dart';
import 'package:passmana/data_object_box/password_box.dart';
import 'package:passmana/data_object_box/user_box.dart';
import 'package:passmana/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

//provides the access to the object box store throughout the app
class ObjectBox {
  late final Store _store;
  late final UserBox userBox;
  late final PasswordBox passwordBox;
  late final GroupBox groupBox;

  ObjectBox._create(this._store) {
    userBox = UserBox(_store);
    passwordBox = PasswordBox(_store);
    groupBox = GroupBox(_store);
  }

  //create an instance of ObjectBox to use throughout the app
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    //pass the directory path to create database file in application folder and passmana subfolder
    //open store function is defined in objectbox.g.dart file
    final store = await openStore(directory: p.join(docsDir.path, "passmana"));
    return ObjectBox._create(store);
  }
}
