/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_actions.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/password_model.dart';
import 'package:redux/redux.dart';

class CreateUpdatePasswordViewModel {
  final Password? password;
  final Function({
    required String title,
    required String subTitle,
    required String userName,
    required String password,
    required String note,
  }) createPassword;
  final Function({
    required String title,
    required String subTitle,
    required String userName,
    required String password,
    required String note,
  }) updatePassword;

  CreateUpdatePasswordViewModel({
    this.password,
    required this.createPassword,
    required this.updatePassword,
  });

  static CreateUpdatePasswordViewModel fromStore(Store<AppState> store, int id) {
    return CreateUpdatePasswordViewModel(
      password: getPasswordById(store.state, id),
      createPassword: ({
        required String title,
        required String subTitle,
        required String userName,
        required String password,
        required String note,
      }) {
        store.dispatch(
          CreatePassword(
            title: title,
            subTitle: subTitle,
            userName: userName,
            password: password,
            note: note,
          ),
        );
      },
      updatePassword: ({
        required String title,
        required String subTitle,
        required String userName,
        required String password,
        required String note,
      }) {
        store.dispatch(
          UpdatePassword(
            password: getPasswordById(store.state, id)?.updatePassword(
                  title: title,
                  subTitle: subTitle,
                  userName: userName,
                  password: password,
                  note: note,
                ) ??
                Password(
                  createdDate: DateTime.now()
                ),
          ),
        );
      },
    );
  }
}
