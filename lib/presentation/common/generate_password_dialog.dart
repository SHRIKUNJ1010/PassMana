/*
* Created by Shrikunj Patel on 1/25/2024.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/cryptography_utility/password_generator.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
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
      title: Text(
        getTranslated('generate_password', context),
        style: TextStyles.getTitleTransparentBlackCustomWeightText(
          fontSize: 16,
          opacity: 1,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.mWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${getTranslated("password", context)}:",
                        style: TextStyles.getTitleDarkRedText(17),
                      ),
                      Text(
                        generatedPassword,
                        maxLines: 5,
                        softWrap: true,
                        style: TextStyles.getTitleWhiteText(17),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: AppColors.primaryColor.withOpacity(0.2),
                        onTap: () {
                          Utility.copyToClipboard(generatedPassword);
                        },
                        child: const Padding(
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
            style: TextStyles.getTitleBlueText(16),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(generatedPassword);
          },
          child: Text(
            getTranslated('confirm', context),
            style: TextStyles.getTitleBlueText(16),
          ),
        ),
      ],
    );
  }

  Container getLengthContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(
            getTranslated('length', context),
            style: TextStyles.getTitleWhiteText(17),
          ),
          Expanded(
            child: Slider(
              min: 8,
              max: 50,
              activeColor: AppColors.mWhite,
              thumbColor: AppColors.mWhite,
              inactiveColor: AppColors.mWhite.withOpacity(0.7),
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
            style: TextStyles.getTitleWhiteText(17),
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
        color: AppColors.primaryColor,
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
                splashColor: AppColors.mWhite.withOpacity(0.2),
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
                    color: AppColors.mWhite,
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
                style: TextStyles.getTitleWhiteText(17),
              ),
              Text(
                '(a-z)',
                style: TextStyles.getTitleWhiteText(17),
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
        color: AppColors.primaryColor,
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
                splashColor: AppColors.mWhite.withOpacity(0.2),
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
                    color: AppColors.mWhite,
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
                style: TextStyles.getTitleWhiteText(17),
              ),
              Text(
                '(A-Z)',
                style: TextStyles.getTitleWhiteText(17),
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
        color: AppColors.primaryColor,
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
                splashColor: AppColors.mWhite.withOpacity(0.2),
                onTap: () {
                  hasNumeric = !hasNumeric;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasNumeric ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.mWhite,
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
                style: TextStyles.getTitleWhiteText(17),
              ),
              Text(
                '(0-9)',
                style: TextStyles.getTitleWhiteText(17),
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
        color: AppColors.primaryColor,
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
                splashColor: AppColors.mWhite.withOpacity(0.2),
                onTap: () {
                  hasSpecialCharacter = !hasSpecialCharacter;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasSpecialCharacter ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.mWhite,
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
                style: TextStyles.getTitleWhiteText(17),
              ),
              Text(
                '(@%+)',
                style: TextStyles.getTitleWhiteText(17),
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
        color: AppColors.primaryColor,
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
                splashColor: AppColors.mWhite.withOpacity(0.2),
                onTap: () {
                  isReadable = !isReadable;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isReadable ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.mWhite,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            getTranslated('pronounceable', context),
            style: TextStyles.getTitleWhiteText(17),
          ),
        ],
      ),
    );
  }
}
