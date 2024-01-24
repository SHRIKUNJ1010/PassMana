/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/generate_password/generate_password_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';

class GeneratePasswordStatefulContainer extends StatefulWidget {
  final GeneratePasswordViewModel vm;

  const GeneratePasswordStatefulContainer({
    super.key,
    required this.vm,
  });

  @override
  State<GeneratePasswordStatefulContainer> createState() => _GeneratePasswordStatefulContainerState();
}

class _GeneratePasswordStatefulContainerState extends State<GeneratePasswordStatefulContainer> {
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
    generatedPassword = widget.vm.generatePassword.call(
      hasUppercase: hasUppercase,
      hasLowercase: hasLowercase,
      hasNumeric: hasNumeric,
      hasSpecialCharacter: hasSpecialCharacter,
      passwordLength: passwordLength,
      isReadable: isReadable,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Utility.getCommonBackgroundDecoration(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(widget.vm, context),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                getGeneratedPasswordContainer(context),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: getLengthContainer(context),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: getUsePasswordButton(),
          ),
        ],
      ),
    );
  }

  ClipRRect getUsePasswordButton() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: InkWell(
          splashColor: AppColors.mWhite.withOpacity(0.2),
          onTap: () {
            widget.vm.onUsePasswordTap.call(generatedPassword);
          },
          child: Container(
            height: 65,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              getTranslated('use_password', context),
              style: TextStyles.getTitleWhiteText(24),
            ),
          ),
        ),
      ),
    );
  }

  Container getGeneratedPasswordContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
      decoration: BoxDecoration(
        color: AppColors.mWhite,
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
                  style: TextStyles.getTitleBlueText(17),
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
                    widget.vm.onCopyPasswordTap.call(generatedPassword);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy,
                      color: AppColors.primaryColor,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getLengthContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      decoration: BoxDecoration(
        color: AppColors.mWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(
            getTranslated('length', context),
            style: TextStyles.getTitleBlueText(17),
          ),
          Expanded(
            child: Slider(
              min: 8,
              max: 50,
              activeColor: AppColors.primaryColor,
              thumbColor: AppColors.primaryColor,
              inactiveColor: AppColors.primaryMaterialColor[400]?.withOpacity(0.7),
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
            style: TextStyles.getTitleBlueText(17),
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
        color: AppColors.mWhite,
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
                splashColor: AppColors.primaryColor.withOpacity(0.2),
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
                    color: AppColors.primaryColor,
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
                style: TextStyles.getTitleBlueText(17),
              ),
              Text(
                '(a-z)',
                style: TextStyles.getTitleBlueText(17),
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
        color: AppColors.mWhite,
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
                splashColor: AppColors.primaryColor.withOpacity(0.2),
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
                    color: AppColors.primaryColor,
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
                style: TextStyles.getTitleBlueText(17),
              ),
              Text(
                '(A-Z)',
                style: TextStyles.getTitleBlueText(17),
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
        color: AppColors.mWhite,
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
                splashColor: AppColors.primaryColor.withOpacity(0.2),
                onTap: () {
                  hasNumeric = !hasNumeric;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasNumeric ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.primaryColor,
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
                style: TextStyles.getTitleBlueText(17),
              ),
              Text(
                '(0-9)',
                style: TextStyles.getTitleBlueText(17),
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
        color: AppColors.mWhite,
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
                splashColor: AppColors.primaryColor.withOpacity(0.2),
                onTap: () {
                  hasSpecialCharacter = !hasSpecialCharacter;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    hasSpecialCharacter ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.primaryColor,
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
                style: TextStyles.getTitleBlueText(17),
              ),
              Text(
                '(@%+)',
                style: TextStyles.getTitleBlueText(17),
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
        color: AppColors.mWhite,
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
                splashColor: AppColors.primaryColor.withOpacity(0.2),
                onTap: () {
                  isReadable = !isReadable;
                  setState(() {});
                  generatePassword();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isReadable ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            getTranslated('pronounceable', context),
            style: TextStyles.getTitleBlueText(17),
          ),
        ],
      ),
    );
  }

  CustomAppBar getAppBar(GeneratePasswordViewModel vm, BuildContext context) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withOpacity(0.2),
                    onTap: () {
                      vm.onBackPress.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("generate_password", context),
          style: TextStyles.getTitleWhiteText(25),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withOpacity(0.2),
                    onTap: () {
                      generatePassword();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.repeat,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
