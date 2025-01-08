/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_bottom_button.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/generate_password/generate_password_view_model.dart';
import 'package:passmana/presentation/generate_password/widgets/check_box_item_tile.dart';
import 'package:passmana/presentation/password/password_details/widgets/details_action_tappable_item_widget.dart';
import 'package:passmana/presentation/password/password_details/widgets/details_item_tile.dart';
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
                DetailsItemTile(
                  title: "${getTranslated("password", context)}:",
                  description: generatedPassword,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  actionItem: DetailsActionTappableItemWidget(
                    onItemTap: () {
                      widget.vm.onCopyPasswordTap.call(generatedPassword);
                    },
                    item: Icon(
                      Icons.copy,
                      color: AppColors.mBlack,
                      size: 25,
                    ),
                  ),
                ),
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
                        child: CheckBoxItemTile(
                          isChecked: hasLowercase,
                          onCheckBoxTapped: () {
                            if (!hasUppercase && hasLowercase) {
                            } else {
                              hasLowercase = !hasLowercase;
                              setState(() {});
                              generatePassword();
                            }
                          },
                          primaryTextTitle: getTranslated('lowercase', context),
                          secondaryTextTitle: '(a-z)',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CheckBoxItemTile(
                          isChecked: hasUppercase,
                          onCheckBoxTapped: () {
                            if (!hasLowercase && hasUppercase) {
                            } else {
                              hasUppercase = !hasUppercase;
                              setState(() {});
                              generatePassword();
                            }
                          },
                          primaryTextTitle: getTranslated('uppercase', context),
                          secondaryTextTitle: '(A-Z)',
                        ),
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
                        child: CheckBoxItemTile(
                          isChecked: hasNumeric,
                          onCheckBoxTapped: () {
                            hasNumeric = !hasNumeric;
                            setState(() {});
                            generatePassword();
                          },
                          primaryTextTitle: getTranslated('numeric', context),
                          secondaryTextTitle: '(0-9)',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CheckBoxItemTile(
                          isChecked: hasSpecialCharacter,
                          onCheckBoxTapped: () {
                            hasSpecialCharacter = !hasSpecialCharacter;
                            setState(() {});
                            generatePassword();
                          },
                          primaryTextTitle: getTranslated('special', context),
                          secondaryTextTitle: '(@%+)',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CheckBoxItemTile(
                      isChecked: isReadable,
                      onCheckBoxTapped: () {
                        isReadable = !isReadable;
                        setState(() {});
                        generatePassword();
                      },
                      primaryTextTitle: getTranslated('pronounceable', context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CommonBottomButton(
              title: getTranslated('use_password', context),
              onItemTap: () {
                widget.vm.onUsePasswordTap.call(generatedPassword);
              },
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
        borderRadius: BorderRadius.circular(3),
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
              inactiveColor: AppColors.primaryMaterialColor[400]?.withValues(alpha: 0.7),
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

  CustomAppBar getAppBar(GeneratePasswordViewModel vm, BuildContext context) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              CommonAppBarActionIconButton(
                onItemTap: () {
                  vm.onBackPress.call();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  size: 25,
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
              CommonAppBarActionIconButton(
                onItemTap: () {
                  generatePassword();
                },
                icon: Icon(
                  Icons.repeat,
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                  size: 25,
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
