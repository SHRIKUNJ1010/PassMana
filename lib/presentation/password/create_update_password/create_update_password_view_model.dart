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
import 'package:redux/redux.dart';

class CreateUpdatePasswordViewModel {
  final Password? password;
  final List<Group> groupSelectOptionList;
  final Function({
    required String title,
    required String subTitle,
    required String userName,
    required String password,
    required String note,
    Group? targetGroup,
  }) createPassword;
  final Function({
    required String title,
    required String subTitle,
    required String userName,
    required String password,
    required String note,
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
        required String userName,
        required String password,
        required String note,
        Group? targetGroup,
      }) {
        store.dispatch(
          CreatePassword(title: title, subTitle: subTitle, userName: userName, password: password, note: note, targetGroup: targetGroup),
        );
      },
      updatePassword: ({
        required String title,
        required String subTitle,
        required String userName,
        required String password,
        required String note,
        Group? targetGroup,
      }) {
        final Password tempPassword = getPasswordById(
              store.state,
              id,
            )?.updatePassword(
              title: title,
              subTitle: subTitle,
              userName: userName,
              password: password,
              note: note,
              lastUpdatedOn: DateTime.now(),
            ) ??
            Password(
              id: id ?? 0,
              createdOn: DateTime.now(),
              lastUpdatedOn: DateTime.now(),
            );

        tempPassword.group.target = targetGroup;
        store.dispatch(
          UpdatePassword(
            password: tempPassword,
          ),
        );
      },
      deletePassword: () {
        //todo: confirmation dialog
        store.dispatch(DeletePassword(passwordId: id ?? 0));
      },
      onBackPress: () {
        router.pop();
      },
    );
  }
}
