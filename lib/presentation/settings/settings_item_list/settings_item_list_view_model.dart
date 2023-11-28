/*
* Created by Shrikunj Patel on 9/13/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class SettingsItemListViewModel {
  final Function(int) onListItemTap;

  SettingsItemListViewModel({
    required this.onListItemTap,
  });

  static SettingsItemListViewModel fromStore(Store<AppState> store) {
    return SettingsItemListViewModel(
      onListItemTap: (int index) {
        switch (index) {
          case 0:
            router.push(AppRoutes.changeMobilePin);
            break;
          case 1:
            router.push(AppRoutes.generatePassword);
            break;
        }
      },
    );
  }
}
