/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class GroupDetailsViewModel {
  final Group group;
  final Function onBackPress;
  final Function onEditTap;
  final Function onPasswordItemTap;
  final Function onCopyPasswordTap;

  GroupDetailsViewModel({
    required this.group,
    required this.onBackPress,
    required this.onEditTap,
    required this.onPasswordItemTap,
    required this.onCopyPasswordTap,
  });

  static GroupDetailsViewModel fromStore(Store<AppState> store, int id) {
    return GroupDetailsViewModel(
      group: getGroupById(store.state, id) ??
          Group(
            createdOn: DateTime.now(),
            lastUpdatedOn: DateTime.now(),
          ),
      onBackPress: () {
        router.pop();
      },
      onEditTap: () {
        router.push(AppRoutes.createUpdateGroup, extra: id);
      },
      onPasswordItemTap: (id) {
        router.push(AppRoutes.passwordDetails, extra: id);
      },
      onCopyPasswordTap: (val) async {
        await Utility.copyToClipboard(val);
      },
    );
  }
}
