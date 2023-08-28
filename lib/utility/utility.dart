/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/foundation.dart';

class Utility {
  //printing log when app is in debug mode
  static void printLog(var log) {
    if (kDebugMode) {
      debugPrint('$log');
    }
  }

}