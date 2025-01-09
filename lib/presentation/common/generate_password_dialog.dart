/*
* Created by Shrikunj Patel on 1/25/2024.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/cryptography_utility/password_generator.dart';
import 'package:passmana/utility/utility.dart';

class GeneratePasswordDialog extends StatefulWidget {
  const GeneratePasswordDialog({super.key});

  @override
  State<GeneratePasswordDialog> createState() => _GeneratePasswordDialogState();
}

class _GeneratePasswordDialogState extends State<GeneratePasswordDialog> {
  bool hasLowercase = true;
  bool hasUppercase = true;
  bool hasNumeric = true;
  bool hasSpecialCharacter = true;
  bool isReadable = true;
  int passwordLength = 20;

  String generatedPassword = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        generatePassword();
      },
    );
    super.initState();
  }

  generatePassword() {
    if (isReadable) {
      generatedPassword = PasswordGenerator.generatePronounceablePassword(
        length: passwordLength,
        withLowerCase: hasLowercase,
        withUpperCase: hasUppercase,
        withSpecialChar: hasSpecialCharacter,
        withDigits: hasNumeric,
      );
    } else {
      generatedPassword = PasswordGenerator.generateRandomPassword(
        length: passwordLength,
        withLowerCase: hasLowercase,
        withUpperCase: hasUppercase,
        withSpecialChar: hasSpecialCharacter,
        withDigits: hasNumeric,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            getTranslated('generate_password', context),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.displayLarge?.color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    generatedPassword,
                    maxLines: 5,
                    softWrap: true,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17, color: AppColors.mWhite),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
                        onTap: () {
                          Utility.copyToClipboard(generatedPassword);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.copy,
                            color: AppColors.mWhite,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          getLengthContainer(context),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: getLowerCaseContainer(context),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: getUpperCaseContainer(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: getNumericContainer(context),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: getSpecialCharacterContainer(context),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              getReadableContainer(context),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop("");
          },
          child: Text(
            getTranslated('cancel', context),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(generatedPassword);
          },
          child: Text(
            getTranslated('confirm', context),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Container getLengthContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(
            getTranslated('length', context),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
          ),
          Expanded(
            child: Slider(
              min: 8,
              max: 50,
              activeColor: Theme.of(context).textTheme.displaySmall?.color,
              thumbColor: Theme.of(context).textTheme.displaySmall?.color,
              inactiveColor: Theme.of(context).textTheme.displaySmall?.color?.withValues(alpha: 0.7),
              value: passwordLength.toDouble(),
              onChanged: (value) {
                if (passwordLength != value.toInt()) {
                  passwordLength = value.toInt();
                  setState(() {});
                  generatePassword();
                }
              },
            ),
          ),
          Text(
            passwordLength.toString(),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Container getLowerCaseContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                onTap: () {
                  if (!hasUppercase && hasLowercase) {
                  } else {
                    hasLowercase = !hasLowercase;
                    setState(() {});
                    generatePassword();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasLowercase ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).textTheme.displaySmall?.color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('lowercase', context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
              Text(
                '(a-z)',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getUpperCaseContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                onTap: () {
                  if (!hasLowercase && hasUppercase) {
                  } else {
                    hasUppercase = !hasUppercase;
                    setState(() {});
                    generatePassword();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasUppercase ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).textTheme.displaySmall?.color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('uppercase', context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
              Text(
                '(A-Z)',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getNumericContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                onTap: () {
                  hasNumeric = !hasNumeric;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasNumeric ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).textTheme.displaySmall?.color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('numeric', context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
              Text(
                '(0-9)',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getSpecialCharacterContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                onTap: () {
                  hasSpecialCharacter = !hasSpecialCharacter;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasSpecialCharacter ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).textTheme.displaySmall?.color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('special', context),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
              Text(
                '(@%+)',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getReadableContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.mWhite.withValues(alpha: 0.2),
                onTap: () {
                  isReadable = !isReadable;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isReadable ? Icons.check_box : Icons.check_box_outline_blank,
                    color: Theme.of(context).textTheme.displaySmall?.color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            getTranslated('pronounceable', context),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
