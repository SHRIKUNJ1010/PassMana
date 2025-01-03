/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_pin_field.dart';
import 'package:passmana/presentation/settings/change_mobile_pin/change_mobile_pin_view_model.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class ChangeMobilePinScreen extends StatefulWidget {
  const ChangeMobilePinScreen({super.key});

  @override
  State<ChangeMobilePinScreen> createState() => _ChangeMobilePinScreenState();
}

class _ChangeMobilePinScreenState extends State<ChangeMobilePinScreen> {
  bool isValidated = false;
  String pin = "";
  String pinErrorMessage = "";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChangeMobilePinViewModel>(
      converter: ChangeMobilePinViewModel.fromStore,
      builder: (BuildContext context, ChangeMobilePinViewModel vm) {
        return Scaffold(
          body: Container(
            color: AppColors.primaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Hero(
                            tag: AppConstants.appLogo,
                            child: Image.asset(AppAssets.appLogoWithoutText),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    isValidated
                        ? pin.isNotEmpty
                            ? getTranslated('confirm_your_pin', context)
                            : getTranslated('create_your_pin', context)
                        : getTranslated('enter_your_pin', context),
                    style: TextStyles.getTitleWhiteText(24),
                  ),
                  Expanded(
                    child: CustomPinField(
                      disableBottomLeft: true,
                      disableBottomRight: false,
                      errorText: pinErrorMessage,
                      bottomRightButtonChild: const Icon(
                        Icons.backspace,
                        color: AppColors.mWhite,
                        size: 25,
                      ),
                      onBottomRightButtonTap: (controller) {
                        if (controller.text.isNotEmpty) {
                          controller.text = controller.text.substring(0, controller.text.length - 1);
                        } else {
                          //validate pin with old pin
                          if (isValidated) {
                            //validate whether new pin is entered or not
                            if (pin.isNotEmpty) {
                              pin = "";
                              pinErrorMessage = "";
                              setState(() {});
                            }
                            //validated old pin but new pin entry pending
                            else {
                              isValidated = false;
                              setState(() {});
                            }
                          }
                          //pin validation is pending
                          else {
                            vm.onBackTap.call();
                          }
                        }
                      },
                      onPinCompleted: (controller) {
                        // validate pin with old pin
                        if (isValidated) {
                          //validate whether new pin is entered or not
                          if (pin.isNotEmpty) {
                            //new pin and confirm pin are same
                            if (pin == controller.text) {
                              pinErrorMessage = "";
                              setState(() {});
                              vm.changePin.call(controller.text);
                              controller.clear();
                            } else {
                              pinErrorMessage = getTranslated("confirm_pin_invalid", context);
                              controller.clear();
                              setState(() {});
                              //todo: generate error confirm pin is invalid
                            }
                          }
                          //validated old pin but new pin entry pending
                          else {
                            //validate entered new pin with old pin value
                            if (controller.text != vm.oldPin) {
                              pin = controller.text;
                              pinErrorMessage = "";
                              setState(() {});
                              controller.clear();
                            }
                            //entered new pin is same as old pin value
                            else {
                              pinErrorMessage = getTranslated("old_and_new_pin_can't_be_same", context);
                              controller.clear();
                              setState(() {});
                              //todo: generate error old pin and new pin can't be same
                            }
                          }
                          // pin validation is pending
                        } else {
                          if (controller.text == vm.oldPin) {
                            isValidated = true;
                            controller.clear();
                            pinErrorMessage = "";
                            setState(() {});
                          } else {
                            //todo: generate error wrong pin entered
                            pinErrorMessage = getTranslated("wrong_pin_entered", context);
                            controller.clear();
                            setState(() {});
                          }
                        }
                      },
                      bottomLeftButtonChild: const SizedBox(),
                      onBottomLeftButtonTap: (controller) {},
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
