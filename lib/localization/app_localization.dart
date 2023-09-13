/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:passmana/router/router.dart';
import 'dart:convert';

import 'package:passmana/utility/constants.dart';

String getTranslated(String key) {
  return AppLocalizations.of(rootNavigatorKey.currentContext!)!.translate(key);
}

class AppLocalizations {
  Map<String, String> _localizedStrings = {};

  static Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations instance = AppLocalizations();
    final String jsonString = await rootBundle.loadString('languages/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    instance._localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return instance;
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return [
      AppConstants.english,
      AppConstants.hindi,
      AppConstants.gujarati,
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return (await AppLocalizations.load(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
