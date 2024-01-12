/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';

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

  static BoxDecoration getCommonBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.10, 0.90],
        colors: [
          AppColors.accentPrimaryColor.withOpacity(0.7),
          AppColors.accentSecondaryColor.withOpacity(0.7),
        ],
      ),
    );
  }

  static String getLanguageNameFromLanguageCode(String code) {
    switch (code) {
      case AppConstants.english:
        return AppConstants.englishName;
      case AppConstants.hindi:
        return AppConstants.hindiName;
      case AppConstants.gujarati:
        return AppConstants.gujaratiName;
      default:
        return AppConstants.englishName;
    }
  }
}
