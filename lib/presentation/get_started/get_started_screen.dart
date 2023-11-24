/*
* Created by Shrikunj Patel on 9/11/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/get_started/get_started_view_model.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/common_widgets_utility/common_widgets.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetStartedViewModel>(
      converter: GetStartedViewModel.fromStore,
      builder: (BuildContext context, GetStartedViewModel vm) {
        return Scaffold(
          body: Container(
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    child: Image.asset(AppAssets.appLogoWithText),
                  ),
                ),
                CommonWidgets.getCommonSplashButton(
                  title: getTranslated('get_started'),
                  height: 55,
                  context: context,
                  onTap: () {
                    vm.onGetStartedPressed.call();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
