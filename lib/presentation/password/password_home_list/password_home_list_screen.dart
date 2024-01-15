/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/password_common_list_tile.dart';
import 'package:passmana/presentation/password/password_home_list/home_group_grid_tile.dart';
import 'package:passmana/presentation/password/password_home_list/password_home_list_view_model.dart';
import 'package:passmana/presentation/password/password_home_list/search_password_widget.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';

class PasswordHomeListScreen extends StatelessWidget {
  const PasswordHomeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordHomeListViewModel>(
      converter: PasswordHomeListViewModel.fromStore,
      onInitialBuild: (PasswordHomeListViewModel vm) {
        vm.getAllData.call();
      },
      builder: (BuildContext context, PasswordHomeListViewModel vm) {
        final double width = MediaQuery.of(context).size.width;

        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm, context),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 7),
                      child: Text(
                        getTranslated("hello_user,", context),
                        softWrap: true,
                        style: TextStyles.getBoldRedText(26),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text(
                        getTranslated("find_your_password", context),
                        softWrap: true,
                        style: TextStyles.getTitleWhiteText(22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: SearchPasswordWidget(
                        onTap: () {
                          vm.onSearchPasswordTap.call();
                        },
                      ),
                    ),
                    getGroupGridHeader(vm, context),
                    getGroupGridView(width, vm, context),
                    getPasswordListHeader(vm, context),
                    getPasswordListView(width, vm, context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(PasswordHomeListViewModel vm, BuildContext context) {
    return CustomAppBar(
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
          getTranslated("password", context),
          style: TextStyles.getTitleWhiteText(28),
        ),
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: AppColors.mWhite,
            child: InkWell(
              splashColor: AppColors.mBlack.withOpacity(0.2),
              onTap: () {
                vm.onGeneratePasswordTap.call();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Icon(
                  Icons.alt_route,
                  color: AppColors.primaryColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget getGroupGridHeader(PasswordHomeListViewModel vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated("popular_groups", context),
            softWrap: true,
            style: TextStyles.getBoldWhiteText(26),
          ),
          vm.seeAllGroups
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        vm.onSeeAllGroupsTap.call();
                      },
                      splashColor: AppColors.mWhite.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          getTranslated("see_all", context),
                          softWrap: true,
                          style: TextStyles.getTitleDarkRedText400(24),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget getPasswordListHeader(PasswordHomeListViewModel vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated("recently_added", context),
            softWrap: true,
            style: TextStyles.getBoldWhiteText(26),
          ),
          vm.seeAllPasswords
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        vm.onSeeAllPasswordsTap.call();
                      },
                      splashColor: AppColors.mWhite.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          getTranslated("see_all", context),
                          softWrap: true,
                          style: TextStyles.getTitleBlueText(24),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget getPasswordListView(double width, PasswordHomeListViewModel vm, BuildContext context) {
    return vm.recentlyAddedPasswordList.isEmpty
        ? Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
            child: SizedBox(
              width: width - 40,
              child: Center(
                child: Text(
                  getTranslated('no_passwords_found', context),
                  style: TextStyles.getTitleWhiteText(20),
                ),
              ),
            ),
          )
        : ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (int i = 0; i < vm.recentlyAddedPasswordList.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: PasswordCommonListTile(
                    password: vm.recentlyAddedPasswordList[i],
                    onTap: () {
                      vm.onPasswordItemTap.call(vm.recentlyAddedPasswordList[i].id);
                    },
                    onClipboardTap: () {
                      vm.onCopyPasswordTap.call(vm.recentlyAddedPasswordList[i].password);
                    },
                  ),
                ),
              ],
            ],
          );
  }

  Widget getGroupGridView(double width, PasswordHomeListViewModel vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: vm.popularGroups.isEmpty
          ? SizedBox(
              width: width - 40,
              child: Center(
                child: Text(
                  getTranslated('no_groups_found', context),
                  style: TextStyles.getTitleWhiteText(20),
                ),
              ),
            )
          : SizedBox(
              width: width - 40,
              height: vm.popularGroups.length > 2 ? width - 40 : (width - 40) / 2,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  for (int i = 0; i < vm.popularGroups.length; i++) ...[
                    HomeGroupGridTile(
                      group: vm.popularGroups[i],
                      onTap: () {
                        vm.onGroupItemTap.call(vm.popularGroups[i].id);
                      },
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
