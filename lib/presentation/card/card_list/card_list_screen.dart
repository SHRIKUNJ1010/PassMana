/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/card/card_list/card_list_view_model.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CardListViewModel>(
      converter: CardListViewModel.fromStore,
      builder: (BuildContext context, CardListViewModel vm) {
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
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
                  getTranslated("card",context),
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