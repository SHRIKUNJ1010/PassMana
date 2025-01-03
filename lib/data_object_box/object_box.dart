/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:passmana/data_object_box/card_box.dart';
import 'package:passmana/data_object_box/group_box.dart';
import 'package:passmana/data_object_box/password_box.dart';
import 'package:passmana/data_object_box/secret_note_box.dart';
import 'package:passmana/data_object_box/user_box.dart';
import 'package:passmana/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//provides the access to the object box store throughout the app
//TODO: "flutter pub run build_runner build" run this command if object box schema
// changed for any of the object box
class ObjectBox {
  late final Store _store;
  //todo: remove admin while releasing your app
  late final Admin _admin;
  late final UserBox userBox;
  late final PasswordBox passwordBox;
  late final GroupBox groupBox;
  late final CardBox cardBox;
  late final SecretNoteBox secretNoteBox;

  ObjectBox._create(this._store) {
    userBox = UserBox(_store);
    passwordBox = PasswordBox(_store);
    groupBox = GroupBox(_store);
    cardBox = CardBox(_store);
    secretNoteBox = SecretNoteBox(_store);
    //todo: remove admin while releasing your app
    if (Admin.isAvailable()) {
      _admin = Admin(_store);
    }
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
