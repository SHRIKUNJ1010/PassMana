/*
* Created by Shrikunj Patel on 9/12/2023.
*/
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_app_bar_back_button_icon.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/password_details/password_details_view_model.dart';
import 'package:passmana/presentation/password/password_details/widgets/details_item_tile.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

import 'widgets/details_action_tappable_item_widget.dart';

class PasswordDetailsScreen extends StatelessWidget {
  final int id;

  const PasswordDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordDetailsViewModel>(
      converter: (Store<AppState> store) {
        return PasswordDetailsViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, PasswordDetailsViewModel vm) {
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm, context),
            body: SafeArea(
              child: vm.password.id == 0
                  ? const SizedBox()
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                alignment: Alignment.center,
                                child: Hero(
                                  tag: "${AppConstants.passwordHero}${vm.password.id}",
                                  child: Text(
                                    vm.password.title.trim()[0].toUpperCase(),
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 34),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        DetailsItemTile(
                          title: "${getTranslated("title", context)}:",
                          description: vm.password.title,
                        ),
                        if (vm.password.subTitle.isNotEmpty) const SizedBox(height: 7),
                        if (vm.password.subTitle.isNotEmpty)
                          DetailsItemTile(
                            title: "${getTranslated("subtitle", context)}:",
                            description: vm.password.subTitle,
                          ),
                        const SizedBox(height: 20),
                        if (vm.password.websiteUrl.isNotEmpty)
                          DetailsItemTile(
                            title: "${getTranslated("website_url", context)}:",
                            description: vm.password.websiteUrl,
                            actionItem: DetailsActionTappableItemWidget(
                              onItemTap: () {
                                vm.onWebsiteUrlTap.call(vm.password.websiteUrl);
                              },
                              item: Transform.rotate(
                                angle: -math.pi / 4,
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        if (vm.password.websiteUrl.isNotEmpty) const SizedBox(height: 7),
                        DetailsItemTile(
                          title: "${getTranslated("email_or_username", context)}:",
                          description: vm.password.userName,
                          actionItem: DetailsActionTappableItemWidget(
                            onItemTap: () {
                              vm.onUsernameCopyTap.call(vm.password.userName);
                            },
                            item: Icon(
                              Icons.copy,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        DetailsItemTile(
                          title: "${getTranslated("password", context)}:",
                          description: vm.password.password,
                          actionItem: DetailsActionTappableItemWidget(
                            onItemTap: () {
                              vm.onPasswordCopyTap.call(vm.password.password);
                            },
                            item: Icon(
                              Icons.copy,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              size: 25,
                            ),
                          ),
                        ),
                        if (vm.password.note.isNotEmpty) const SizedBox(height: 20),
                        if (vm.password.note.isNotEmpty)
                          DetailsItemTile(
                            title: "${getTranslated("note", context)}:",
                            description: vm.password.note,
                          ),
                        if (vm.dynamicFields.call().isNotEmpty) const SizedBox(height: 20),
                        if (vm.dynamicFields.call().isNotEmpty) ...[
                          for (int i = 0; i < vm.dynamicFields.call().length; i++) ...[
                            DetailsItemTile(
                              title: vm.dynamicFields.call()[i].title ?? "",
                              description: vm.dynamicFields.call()[i].value ?? "",
                            ),
                            if (i != (vm.dynamicFields.call().length - 1)) const SizedBox(height: 7),
                          ],
                        ],
                        const SizedBox(height: 20),
                        DetailsItemTile(
                          title: "${getTranslated("category_group", context)}:",
                          description: vm.password.group.target?.groupName ?? getTranslated('none', context),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(PasswordDetailsViewModel vm, BuildContext context) {
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
                icon: CommonAppBarBackButtonIcon(),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("password_details", context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
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
