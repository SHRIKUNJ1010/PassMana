/*
* Created by Shrikunj Patel on 8/25/2023.
*/

import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  String pin;
  String masterPassword;

  User({this.id = 0,this.masterPassword = '',this.pin = ''});

  setPin(String pin) {
    this.pin = pin;
  }

  setMasterPassword(String masterPassword) {
    this.masterPassword = masterPassword;
  }
}