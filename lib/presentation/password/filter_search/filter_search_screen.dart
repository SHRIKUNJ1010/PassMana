/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/filter_search/filter_search_actions.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/common_app_bar_action_icon_button.dart';
import 'package:passmana/presentation/common/common_app_bar_back_button_icon.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/filter_search/filter_search_view_model.dart';
import 'package:passmana/presentation/password/filter_search/widgets/search_password_field.dart';
import 'package:passmana/presentation/password/password_home_list/widgets/password_common_list_tile.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FilterSearchViewModel>(
      converter: FilterSearchViewModel.fromStore,
      onInit: (Store<AppState> store) {
        store.dispatch(InitializeFilter());
      },
      builder: (BuildContext context, FilterSearchViewModel vm) {
        final double width = MediaQuery.of(context).size.width;
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm, context),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: SearchPasswordField(
                      onTextChanged: (val) {
                        vm.changeKeyword.call(val);
                      },
                    ),
                  ),
                  Expanded(
                    child: getPasswordListView(width, vm, context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(FilterSearchViewModel vm, BuildContext context) {
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
          getTranslated("filter_search", context),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
        ),
        const Spacer(),
      ],
    );
  }

  Widget getPasswordListView(double width, FilterSearchViewModel vm, BuildContext context) {
    return vm.searchedPasswordList.isEmpty
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
            shrinkWrap: true,
            itemCount: vm.searchedPasswordList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: PasswordCommonListTile(
                  password: vm.searchedPasswordList[index],
                  onTap: () {
                    vm.onPasswordTileTap.call(vm.searchedPasswordList[index].id);
                  },
                  onClipboardTap: () {
                    vm.onCopyTap.call(vm.searchedPasswordList[index].password);
                  },
                ),
              );
            },
          );
  }
}
