/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class SettingsItemListViewModel {
  final List<String> listItemTitles;
  final Function(int) onListItemTap;

  SettingsItemListViewModel({
    required this.listItemTitles,
    required this.onListItemTap,
  });

  static SettingsItemListViewModel fromStore(Store<AppState> store) {
    return SettingsItemListViewModel(
      listItemTitles: [
        getTranslated("change_master_password"),
        getTranslated("change_mobile_pin"),
        getTranslated("generate_password"),
      ],
      onListItemTap: (int index) {
        switch (index) {
          case 0:
            router.push(AppRoutes.changeMasterPassword);
            break;
          case 1:
            router.push(AppRoutes.changeMobilePin);
            break;
          case 2:
            router.push(AppRoutes.generatePassword);
            break;
        }
      },
    );
  }
}
