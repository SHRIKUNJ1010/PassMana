/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/group/group_details/group_details_password_list_tile.dart';
import 'package:passmana/presentation/group/group_details/group_details_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class GroupDetailsScreen extends StatelessWidget {
  final int id;

  const GroupDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupDetailsViewModel>(
      converter: (Store<AppState> store) {
        return GroupDetailsViewModel.fromStore(store, id);
      },
      builder: (BuildContext context, GroupDetailsViewModel vm) {
        final double width = MediaQuery.of(context).size.width;
        final double height = MediaQuery.of(context).size.height;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm),
            body: vm.group.id == 0
                ? const SizedBox()
                : ListView(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    shrinkWrap: true,
                    children: [
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
                                color: AppColors.mWhite,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                              alignment: Alignment.center,
                              child: Text(
                                vm.group.groupName.trim()[0].toUpperCase(),
                                style: TextStyles.getBoldRedText(34),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vm.group.groupName,
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.getTitleWhiteText(32),
                            ),
                          ],
                        ),
                      ),
                      vm.group.description.isEmpty ? const SizedBox() : const SizedBox(height: 5),
                      vm.group.description.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        vm.group.description,
                                        maxLines: 10000,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.getTitleWhiteText(16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(height: 25),
                      Container(
                        width: width,
                        decoration: const BoxDecoration(
                          color: AppColors.mWhite,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              getTranslated("passwords"),
                              style: TextStyles.getTitleDarkRedText(26),
                            ),
                            const SizedBox(height: 15),
                            if (vm.group.passwords.isEmpty) ...[
                              SizedBox(
                                width: width - 40,
                                height: height * 0.5,
                                child: Center(
                                  child: Text(
                                    getTranslated('no_password_assigned'),
                                    style: TextStyles.getTitleBlueText(26),
                                  ),
                                ),
                              ),
                            ] else ...[
                              for (int i = 0; i < vm.group.passwords.length; i++) ...[
                                GroupPasswordListTile(
                                  width: width,
                                  item: vm.group.passwords[i],
                                  onItemTap: () {
                                    vm.onPasswordItemTap.call(vm.group.passwords[i].id);
                                  },
                                  onClipboardTap: () {
                                    vm.onCopyPasswordTap.call(vm.group.passwords[i].password);
                                  },
                                ),
                              ],
                            ],
                            SizedBox(height: vm.group.passwords.length < 5 ? 400 : 80),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(GroupDetailsViewModel vm) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withOpacity(0.2),
                    onTap: () {
                      vm.onBackPress.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("group_details"),
          style: TextStyles.getTitleWhiteText(25),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withOpacity(0.2),
                    onTap: () {
                      vm.onEditTap.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
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
