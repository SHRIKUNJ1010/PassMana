/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';

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

  static void bottomBarOnTap(int index) {
    switch (index) {
      case 0:
        router.go(AppRoutes.passwordList);
        break;
      case 1:
        router.go(AppRoutes.groupList);
        break;
      case 2:
        router.go(AppRoutes.createList);
        break;
      case 3:
        router.go(AppRoutes.generatePassword);
        break;
      case 4:
        router.go(AppRoutes.settings);
        break;
      default:
        router.go(AppRoutes.passwordList);
    }
  }
}
