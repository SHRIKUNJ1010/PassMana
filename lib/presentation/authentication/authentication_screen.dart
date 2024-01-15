/*
* Created by Shrikunj Patel on 9/11/2023.
*/
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/user/user_actions.dart';
import 'package:passmana/domain_redux/user/user_selector.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/authentication/authentication_view_model.dart';
import 'package:passmana/presentation/common/custom_pin_field.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:redux/redux.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthenticationViewModel>(
      converter: AuthenticationViewModel.fromStore,
      onInit: (Store<AppState> store) {
        if (getIsBiometricEnabled(store.state)) {
          store.dispatch(
            VerifyUserBiometric(
              onVerified: () {
                router.go(AppRoutes.passwordHomeList);
              },
              onNotVerified: () {
                //do nothing
              },
            ),
          );
        }
      },
      builder: (BuildContext context, AuthenticationViewModel vm) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
                    getTranslated('enter_your_pin', context),
                    style: TextStyles.getTitleWhiteText(24),
                  ),
                  Expanded(
                    child: CustomPinField(
                      disableBottomLeft: !vm.isBiometricEnabled,
                      disableBottomRight: false,
                      bottomRightButtonChild: const Icon(
                        Icons.backspace,
                        color: AppColors.mWhite,
                        size: 25,
                      ),
                      onBottomRightButtonTap: vm.onBackTap,
                      onPinCompleted: (controller) {
                        vm.verifyPin.call(controller);
                      },
                      bottomLeftButtonChild: vm.isBiometricEnabled
                          ? const Icon(
                              Icons.fingerprint,
                              color: AppColors.mWhite,
                              size: 32,
                            )
                          : const SizedBox(),
                      onBottomLeftButtonTap: (controller) {
                        vm.verifyBiometric.call();
                      },
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
