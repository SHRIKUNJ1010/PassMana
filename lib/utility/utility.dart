/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Utility {
  //printing log when app is in debug mode
  static void printLog(var log) {
    if (kDebugMode) {
      debugPrint('$log');
    }
  }

  //function to copy string data to clip board
  static Future<void> copyToClipboard(String data) async {
    await Clipboard.setData(ClipboardData(text: data));
  }
}
