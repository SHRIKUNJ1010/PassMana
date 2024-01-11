/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/all_password_list/all_password_list_view_model.dart';
import 'package:passmana/presentation/password/password_common_list_tile.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';

class AllPasswordListScreen extends StatelessWidget {
  const AllPasswordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AllPasswordListViewModel>(
      converter: AllPasswordListViewModel.fromStore,
      builder: (BuildContext context, AllPasswordListViewModel vm) {
        final double width = MediaQuery.of(context).size.width;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm),
            body: SafeArea(
              child: getPasswordListView(width, vm),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(AllPasswordListViewModel vm) {
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
          getTranslated("passwords"),
          style: TextStyles.getTitleWhiteText(25),
        ),
        const Spacer(),
      ],
    );
  }

  Widget getPasswordListView(double width, AllPasswordListViewModel vm) {
    return vm.passwordList.isEmpty
        ? Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: SizedBox(
              width: width - 40,
              child: Center(
                child: Text(
                  getTranslated('no_passwords_found'),
                  style: TextStyles.getTitleWhiteText(20),
                ),
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
            shrinkWrap: true,
            itemCount: vm.passwordList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: PasswordCommonListTile(
                  password: vm.passwordList[index],
                  onTap: () {
                    vm.onPasswordTileTap.call(vm.passwordList[index].id);
                  },
                  onClipboardTap: () {
                    vm.onCopyTap.call(vm.passwordList[index].password);
                  },
                ),
              );
            },
          );
  }
}
