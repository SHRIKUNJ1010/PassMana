/*
* Created by Shrikunj Patel on 9/12/2023.
*/
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/password_details/password_details_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

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
                                  color: AppColors.mWhite,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                alignment: Alignment.center,
                                child: Text(
                                  vm.password.title.trim()[0].toUpperCase(),
                                  style: TextStyles.getBoldRedText(34),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        getTitleContainer(vm, context),
                        if (vm.password.subTitle.isNotEmpty) const SizedBox(height: 7),
                        if (vm.password.subTitle.isNotEmpty) getSubTitleContainer(vm, context),
                        const SizedBox(height: 20),
                        if (vm.password.websiteUrl.isNotEmpty) getWebsiteUrlContainer(vm, context),
                        if (vm.password.websiteUrl.isNotEmpty) const SizedBox(height: 7),
                        getUsernameContainer(vm, context),
                        const SizedBox(height: 7),
                        getPasswordContainer(vm, context),
                        if (vm.password.note.isNotEmpty) const SizedBox(height: 20),
                        if (vm.password.note.isNotEmpty) getNoteContainer(vm, context),
                        if (vm.dynamicFields.call().isNotEmpty) const SizedBox(height: 20),
                        if (vm.dynamicFields.call().isNotEmpty) ...[
                          for (int i = 0; i < vm.dynamicFields.call().length; i++) ...[
                            getCustomFieldItemContainer(
                              vm.dynamicFields.call()[i].title ?? "",
                              vm.dynamicFields.call()[i].value ?? "",
                              context,
                            ),
                            if (i != (vm.dynamicFields.call().length - 1)) const SizedBox(height: 7),
                          ],
                        ],
                        const SizedBox(height: 20),
                        getAssignedToGroupContainer(vm, context),
                        const SizedBox(height: 80),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Container getCommonContainer({
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mWhite,
      ),
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      child: child,
    );
  }

  Widget getAssignedToGroupContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("category_group", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  vm.password.group.target?.groupName ?? getTranslated('none', context),
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getCustomFieldItemContainer(String title, String value, BuildContext context) {
    return getCommonContainer(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  value,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container getNoteContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("note", context)}:",
            style: TextStyles.getTitleDarkRedText(17),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  vm.password.note,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getPasswordContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("password", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  vm.password.password,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
                  onTap: () {
                    vm.onPasswordCopyTap.call(vm.password.password);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy,
                      color: AppColors.mBlack,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getWebsiteUrlContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("website_url", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  vm.password.websiteUrl,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
                  onTap: () {
                    vm.onWebsiteUrlTap.call(vm.password.websiteUrl);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.rotate(
                      angle: -math.pi / 4,
                      child: const Icon(
                        Icons.arrow_right_alt,
                        color: AppColors.mBlack,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getUsernameContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("email_or_username", context)}:",
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  vm.password.userName,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
                  onTap: () {
                    vm.onUsernameCopyTap.call(vm.password.userName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.copy,
                      color: AppColors.mBlack,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container getSubTitleContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("subtitle", context)}:",
            style: TextStyles.getTitleDarkRedText(17),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  vm.password.subTitle,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container getTitleContainer(PasswordDetailsViewModel vm, BuildContext context) {
    return getCommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("title", context)}:",
            style: TextStyles.getTitleDarkRedText(17),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  vm.password.title,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withValues(alpha: 0.2),
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
          getTranslated("password_details", context),
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
                    splashColor: AppColors.mBlack.withValues(alpha: 0.2),
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
