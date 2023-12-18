/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/create_list/create_list_item_widget.dart';
import 'package:passmana/presentation/create_list/create_list_view_model.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CreateListScreen extends StatelessWidget {
  const CreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateListViewModel>(
      converter: CreateListViewModel.fromStore,
      builder: (BuildContext context, CreateListViewModel vm) {
        final double height = MediaQuery.of(context).size.height;
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
                  getTranslated("passmana"),
                  style: TextStyles.getTitleWhiteText(28),
                ),
                const Spacer(),
              ],
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: Text(
                      getTranslated("what_do_you_want_to"),
                      softWrap: true,
                      style: TextStyles.getTitleWhiteText(18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Text(
                      getTranslated("store_today?"),
                      softWrap: true,
                      style: TextStyles.getTitleWhiteText(42),
                    ),
                  ),
                  Container(
                    height: 0.5 * height,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: CreateListItemTile(
                                  onTap: () {
                                    vm.onPasswordItemTap.call();
                                  },
                                  title: getTranslated("password"),
                                  icon: Icon(
                                    Icons.lock,
                                    color: AppColors.mBlack.withOpacity(0.6),
                                    size: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CreateListItemTile(
                                  onTap: () {
                                    vm.onGroupItemTap.call();
                                  },
                                  title: getTranslated("group"),
                                  icon: Icon(
                                    Icons.people,
                                    color: AppColors.mBlack.withOpacity(0.6),
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: CreateListItemTile(
                                  onTap: () {
                                    vm.onCardItemTap.call();
                                  },
                                  title: getTranslated("card"),
                                  icon: Icon(
                                    Icons.credit_card,
                                    color: AppColors.mBlack.withOpacity(0.6),
                                    size: 50,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CreateListItemTile(
                                  onTap: () {
                                    vm.onSecretNoteItemTap.call();
                                  },
                                  title: getTranslated("secret_note"),
                                  icon: Icon(
                                    Icons.note_alt,
                                    color: AppColors.mBlack.withOpacity(0.6),
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
