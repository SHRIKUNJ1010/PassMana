/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateListViewModel {
  final Function(int) onListItemTap;

  CreateListViewModel({
    required this.onListItemTap,
  });

  static CreateListViewModel fromStore(Store<AppState> store) {
    return CreateListViewModel(
      onListItemTap: (int index) {
        switch(index) {
          case 0:
            router.push(AppRoutes.createUpdatePassword);
            break;
          case 1:
            router.push(AppRoutes.createUpdateGroup);
            break;
        }
      },
    );
  }
}
