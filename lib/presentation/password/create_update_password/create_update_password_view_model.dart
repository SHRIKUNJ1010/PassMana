/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/group/group_selector.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class CreateUpdatePasswordViewModel {
  final Password? password;
  final List<Group> groupSelectOptionList;
  final Function({
    required String title,
    required String subTitle,
    required String websiteUrl,
    required String userName,
    required String password,
    required String note,
    required String dynamicDataField,
    Group? targetGroup,
  }) createPassword;
  final Function({
    required String title,
    required String subTitle,
    required String websiteUrl,
    required String userName,
    required String password,
    required String note,
    required String dynamicDataField,
    Group? targetGroup,
  }) updatePassword;
  final Function deletePassword;
  final Function onBackPress;

  CreateUpdatePasswordViewModel({
    this.password,
    required this.groupSelectOptionList,
    required this.createPassword,
    required this.updatePassword,
    required this.deletePassword,
    required this.onBackPress,
  });

  static CreateUpdatePasswordViewModel fromStore(Store<AppState> store, int? id) {
    return CreateUpdatePasswordViewModel(
      password: getPasswordById(store.state, id),
      groupSelectOptionList: getGroupList(store.state),
      createPassword: ({
        required String title,
        required String subTitle,
        required String websiteUrl,
        required String userName,
        required String password,
        required String note,
        required String dynamicDataField,
        Group? targetGroup,
      }) {
        store.dispatch(
          CreatePassword(
            title: title,
            subTitle: subTitle,
            websiteUrl: websiteUrl,
            userName: userName,
            password: password,
            note: note,
            dynamicDataField: dynamicDataField,
            targetGroup: targetGroup,
          ),
        );
        router.pop();
      },
      updatePassword: ({
        required String title,
        required String subTitle,
        required String websiteUrl,
        required String userName,
        required String password,
        required String note,
        required String dynamicDataField,
        Group? targetGroup,
      }) {
        store.dispatch(
          UpdatePassword(
            id: id ?? 0,
            title: title,
            subTitle: subTitle,
            websiteUrl: websiteUrl,
            userName: userName,
            password: password,
            note: note,
            dynamicDataField: dynamicDataField,
            targetGroup: targetGroup,
          ),
        );
        router.pop();
      },
      deletePassword: () async {
        bool hasConfirmed = await Utility.deleteConfirmationDialog();
        if (hasConfirmed) {
          store.dispatch(DeletePassword(passwordId: id ?? 0));
          router.go(AppRoutes.passwordHomeList);
        }
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
