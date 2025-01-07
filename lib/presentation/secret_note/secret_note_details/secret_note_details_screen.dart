/*
* Created by Shrikunj Patel on 12/13/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/secret_note/secret_note_details/secret_note_details_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class SecretNoteDetailsScreen extends StatelessWidget {
  final int id;

  const SecretNoteDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SecretNoteDetailsViewModel>(
      converter: (Store<AppState> store) {
        return SecretNoteDetailsViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, SecretNoteDetailsViewModel vm) {
        final double width = MediaQuery.of(context).size.width;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm, context),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.mWhite,
                ),
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  shrinkWrap: true,
                  children: [
                    SizedBox(width: width),
                    Hero(
                      tag: "${AppConstants.secretNoteHero}${vm.secretNote.id}",
                      child: Text(
                        vm.secretNote.note,
                        style: TextStyles.getTitleBlueText(18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(SecretNoteDetailsViewModel vm, BuildContext context) {
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
                  color: AppColors.primaryColor,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("secret_note_details", context),
          style: TextStyles.getTitleWhiteText(25),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonAppBarActionIconButton(
                onItemTap: () {
                  vm.onEditTap.call();
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
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
