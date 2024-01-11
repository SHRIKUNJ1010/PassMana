/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class PasswordDetailsViewModel {
  final Password password;
  final Function onBackPress;
  final Function onEditTap;
  final Function(String) onUsernameCopyTap;
  final Function(String) onPasswordCopyTap;

  PasswordDetailsViewModel({
    required this.password,
    required this.onBackPress,
    required this.onEditTap,
    required this.onPasswordCopyTap,
    required this.onUsernameCopyTap,
  });

  static PasswordDetailsViewModel fromStore(Store<AppState> store, int id) {
    return PasswordDetailsViewModel(
      password: getPasswordById(store.state, id) ??
          Password(
            createdOn: DateTime.now(),
            lastUpdatedOn: DateTime.now(),
          ),
      onBackPress: () {
        router.pop();
      },
      onEditTap: () {
        router.push(AppRoutes.createUpdatePassword, extra: id);
      },
      onPasswordCopyTap: (val) async {
        await Utility.copyToClipboard(val);
      },
      onUsernameCopyTap: (val) async {
        await Utility.copyToClipboard(val);
      },
    );
  }
}
