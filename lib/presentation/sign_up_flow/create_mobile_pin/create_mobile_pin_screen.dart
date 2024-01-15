/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_pin_field.dart';
import 'package:passmana/presentation/sign_up_flow/create_mobile_pin/create_mobile_pin_view_model.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CreateMobilePinScreen extends StatelessWidget {
  const CreateMobilePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateMobilePinViewModel>(
      converter: CreateMobilePinViewModel.fromStore,
      builder: (BuildContext context, CreateMobilePinViewModel vm) {
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
                    vm.isConfirm ? getTranslated('confirm_your_pin',context) : getTranslated('create_your_pin',context),
                    style: TextStyles.getTitleWhiteText(24),
                  ),
                  Expanded(
                    child: CustomPinField(
                      disableBottomLeft: true,
                      disableBottomRight: false,
                      bottomRightButtonChild: const Icon(
                        Icons.backspace,
                        color: AppColors.mWhite,
                        size: 25,
                      ),
                      onBottomRightButtonTap: vm.onBackTap,
                      onPinCompleted: vm.onSubmitTap,
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
