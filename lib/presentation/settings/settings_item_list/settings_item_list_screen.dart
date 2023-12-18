/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/settings/settings_item_list/settings_item_list_view_model.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class SettingsItemListScreen extends StatelessWidget {
  const SettingsItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsItemListViewModel>(
      converter: SettingsItemListViewModel.fromStore,
      builder: (BuildContext context, SettingsItemListViewModel vm) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.10, 0.90],
              colors: [
                AppColors.accentPrimaryColor.withOpacity(0.7),
                AppColors.accentSecondaryColor.withOpacity(0.7),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              centerWidgetsList: [
                const SizedBox(width: 20),
                SizedBox(
                  width: 40,
                  child: Hero(
                    tag: AppConstants.appLogo,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(AppAssets.appLogoWithoutText),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  getTranslated("settings"),
                  style: TextStyles.getTitleWhiteText(28),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
