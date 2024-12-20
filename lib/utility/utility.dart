/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_confirmation_dialog.dart';
import 'package:passmana/presentation/common/generate_password_dialog.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //launch given url to external application
  static Future<void> launchUrlInExternalApplication(String url) async {
    Uri tempUri = Uri.parse(url);
    try {
      await launchUrl(tempUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      Utility.printLog("Error While Launching Url: $url ::::: ${e.toString()}");
    }
  }

  static BoxDecoration getCommonBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.10, 0.90],
        colors: [
          AppColors.accentPrimaryColor.withValues(alpha: 0.9),
          AppColors.accentSecondaryColor.withValues(alpha: 0.9),
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

  static Future<String> generatePasswordDialog() async {
    String? value = await showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return const GeneratePasswordDialog();
      },
    );
    return value ?? "";
  }

  static exportedDbFileLocationDialog(String filePath) async {
    await showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            getTranslated('db_file_location', context),
            style: TextStyles.getTitleTransparentBlackCustomWeightText(
              fontSize: 16,
              opacity: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            "${getTranslated('your_db_file_location_is', context)}: $filePath",
            style: TextStyles.getTitleTransparentBlackCustomWeightText(
              fontSize: 16,
              opacity: 1,
              fontWeight: FontWeight.normal,
            ),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                getTranslated('confirm', context),
                style: TextStyles.getTitleBlueText(16),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> deleteConfirmationDialog() async {
    bool? value = await showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return CommonConfirmationDialog(
          title: getTranslated("confirmation", context),
          message: getTranslated("delete_confirmation", context),
          positiveBtnText: getTranslated("yes", context),
          negativeBtnText: getTranslated("no", context),
        );
      },
    );
    return value ?? false;
  }

  static Future<bool> discardDataConfirmationDialog() async {
    bool? value = await showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return CommonConfirmationDialog(
          title: getTranslated("confirmation", context),
          message: getTranslated("discard_confirmation", context),
          positiveBtnText: getTranslated("yes", context),
          negativeBtnText: getTranslated("no", context),
        );
      },
    );
    return value ?? false;
  }
}
