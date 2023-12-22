/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:redux/redux.dart';

class AllPasswordListViewModel {
  final List<Password> passwordList;
  final Function onBackPress;
  final Function(int) onPasswordTileTap;

  AllPasswordListViewModel({
    required this.passwordList,
    required this.onBackPress,
    required this.onPasswordTileTap,
  });

  static AllPasswordListViewModel fromStore(Store<AppState> store) {
    return AllPasswordListViewModel(
      passwordList: getPasswordList(store.state),
      onBackPress: () {
        router.pop();
      },
      onPasswordTileTap: (id) {
        router.push(AppRoutes.passwordDetails, extra: id);
      },
    );
  }
}
