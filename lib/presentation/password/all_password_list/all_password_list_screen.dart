/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_app_bar_back_button_icon.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/all_password_list/all_password_list_view_model.dart';
import 'package:passmana/presentation/password/password_home_list/widgets/password_common_list_tile.dart';
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
            appBar: getAppBar(vm, context),
            body: SafeArea(
              child: getPasswordListView(width, vm, context),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(AllPasswordListViewModel vm, BuildContext context) {
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
          getTranslated("passwords", context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
        ),
        const Spacer(),
      ],
    );
  }

  Widget getPasswordListView(double width, AllPasswordListViewModel vm, BuildContext context) {
    return vm.passwordList.isEmpty
        ? Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: SizedBox(
              width: width - 40,
              child: Center(
                child: Text(
                  getTranslated('no_passwords_found', context),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
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
