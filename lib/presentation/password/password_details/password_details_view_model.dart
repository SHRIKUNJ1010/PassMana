/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'dart:convert';

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/domain_redux/password/password_selector.dart';
import 'package:passmana/model/password_dynamic_field_model.dart';
import 'package:passmana/model/password_model.dart';
import 'package:passmana/model/screen_argument_models/create_update_password_screen_arguments.dart';
import 'package:passmana/router/router.dart';
import 'package:passmana/utility/page_routes_utility/page_routes.dart';
import 'package:passmana/utility/utility.dart';
import 'package:redux/redux.dart';

class PasswordDetailsViewModel {
  final Password password;
  final List<PasswordDynamicField> Function() dynamicFields;
  final Function onBackPress;
  final Function onEditTap;
  final Function(String) onWebsiteUrlTap;
  final Function(String) onUsernameCopyTap;
  final Function(String) onPasswordCopyTap;

  PasswordDetailsViewModel({
    required this.password,
    required this.dynamicFields,
    required this.onBackPress,
    required this.onEditTap,
    required this.onWebsiteUrlTap,
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
      dynamicFields: () {
        List<PasswordDynamicField> tempList = [];
        try {
          tempList = PasswordDynamicFieldList.fromJson(jsonDecode(getPasswordById(store.state, id)?.dynamicDataField ?? "{}")).dynamicField ??
              [PasswordDynamicField()];
        } catch (e) {
          tempList = [PasswordDynamicField()];
        }
        if (tempList.isEmpty || (tempList.length == 1 && (tempList[0].title == null || tempList[0].title!.isEmpty))) {
          return [];
        } else {
          return tempList;
        }
      },
      onBackPress: () {
        router.pop();
      },
      onEditTap: () {
        router.push(AppRoutes.createUpdatePassword, extra: CreateUpdatePasswordScreenArguments(id: id));
      },
      onPasswordCopyTap: (val) async {
        await Utility.copyToClipboard(val);
      },
      onUsernameCopyTap: (val) async {
        await Utility.copyToClipboard(val);
      },
      onWebsiteUrlTap: (val) async {
        await Utility.launchUrlInExternalApplication(val);
      },
    );
  }
}
