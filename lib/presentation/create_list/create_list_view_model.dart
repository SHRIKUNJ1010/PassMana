/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class CreateListViewModel {
  final Function onPasswordItemTap;
  final Function onGroupItemTap;
  final Function onCardItemTap;
  final Function onSecretNoteItemTap;

  CreateListViewModel({
    required this.onPasswordItemTap,
    required this.onGroupItemTap,
    required this.onCardItemTap,
    required this.onSecretNoteItemTap,
  });

  static CreateListViewModel fromStore(Store<AppState> store) {
    return CreateListViewModel(
      onPasswordItemTap: () {
        router.push(AppRoutes.createUpdatePassword);
      },
      onGroupItemTap: () {
        router.push(AppRoutes.createUpdateGroup);
      },
      onCardItemTap: () {
        router.push(AppRoutes.createUpdatePassword);
      },
      onSecretNoteItemTap: () {
        router.push(AppRoutes.createUpdatePassword);
      },
    );
  }
}
