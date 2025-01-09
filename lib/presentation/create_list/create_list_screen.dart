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
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/utility.dart';

class CreateListScreen extends StatelessWidget {
  const CreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateListViewModel>(
      converter: CreateListViewModel.fromStore,
      builder: (BuildContext context, CreateListViewModel vm) {
        final double height = MediaQuery.of(context).size.height;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
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
                  getTranslated("passmana", context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 28),
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
                      getTranslated("what_do_you_want_to", context),
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Text(
                      getTranslated("store_today?", context),
                      softWrap: true,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 42),
                    ),
                  ),
                  getGridList(height, vm, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container getGridList(double height, CreateListViewModel vm, BuildContext context) {
    //TODO: adjust ui for tablet create options does not suit screen
    return Container(
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
                    title: getTranslated("password", context),
                    heroTag: AppConstants.passwordHero,
                    icon: Icon(
                      Icons.lock,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: CreateListItemTile(
                    onTap: () {
                      vm.onGroupItemTap.call();
                    },
                    title: getTranslated("group", context),
                    heroTag: AppConstants.groupHero,
                    icon: Icon(
                      Icons.people,
                      color: Theme.of(context).textTheme.bodySmall?.color,
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
                    title: getTranslated("card", context),
                    heroTag: AppConstants.cardHero,
                    icon: Icon(
                      Icons.credit_card,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: CreateListItemTile(
                    onTap: () {
                      vm.onSecretNoteItemTap.call();
                    },
                    title: getTranslated("secret_note", context),
                    heroTag: AppConstants.secretNoteHero,
                    icon: Icon(
                      Icons.note_alt,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
