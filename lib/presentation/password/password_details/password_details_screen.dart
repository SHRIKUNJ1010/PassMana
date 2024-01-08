/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/common/drop_down_search_custom/dropdown_search.dart';
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
        final double width = MediaQuery.of(context).size.width;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 80),
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
                const SizedBox(height: 10),
                getCommonContainer(
                  width,
                  [
                    getTitleContainer(vm),
                    vm.password.subTitle.isEmpty ? const SizedBox() : const SizedBox(height: 7),
                    vm.password.subTitle.isEmpty ? const SizedBox() : getSubTitleContainer(vm),
                  ],
                ),
                const SizedBox(height: 15),
                getCommonContainer(
                  width,
                  [
                    getUsernameContainer(vm),
                    const SizedBox(height: 7),
                    getPasswordContainer(vm),
                  ],
                ),
                vm.password.note.isEmpty ? const SizedBox() : const SizedBox(height: 15),
                vm.password.note.isEmpty
                    ? const SizedBox()
                    : getCommonContainer(
                        width,
                        [
                          getNoteContainer(vm),
                        ],
                      ),
                const SizedBox(height: 15),
                getCommonContainer(
                  width,
                  [
                    getAssignedToGroupContainer(vm),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container getCommonContainer(double width, List<Widget> children) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.accentPrimary[100],
        borderRadius: BorderRadius.circular(7),
      ),
      padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget getAssignedToGroupContainer(PasswordDetailsViewModel vm) {
    return DropdownSearch<Group>(
      selectedItemBuilder: (item, onTap) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Material(
            color: AppColors.mWhite,
            child: InkWell(
              onTap: () {
                onTap.call();
              },
              splashColor: AppColors.secondaryColor.withOpacity(0.2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${getTranslated("category_group")}:",
                            style: TextStyles.getTitleDarkRedText(17),
                          ),
                          Text(
                            item?.groupName ?? getTranslated('none'),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: AppColors.primaryColor.withOpacity(0.2),
                            onTap: () {
                              onTap.call();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
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
              ),
            ),
          ),
        );
      },
    );
  }

  Container getNoteContainer(PasswordDetailsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mWhite,
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("note")}:",
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

  Container getPasswordContainer(PasswordDetailsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mWhite,
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("password")}:",
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
                  splashColor: AppColors.primaryColor.withOpacity(0.2),
                  onTap: () {},
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

  Container getUsernameContainer(PasswordDetailsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mWhite,
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${getTranslated("email_or_username")}:",
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
                  splashColor: AppColors.primaryColor.withOpacity(0.2),
                  onTap: () {},
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

  Container getSubTitleContainer(PasswordDetailsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mWhite,
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("subtitle")}:",
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

  Container getTitleContainer(PasswordDetailsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.mWhite,
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getTranslated("title")}:",
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

  CustomAppBar getAppBar(PasswordDetailsViewModel vm) {
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
          getTranslated("password_details"),
          style: TextStyles.getTitleWhiteText(25),
        ),
        const Spacer(),
      ],
    );
  }
}
