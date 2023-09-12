/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/model/password_model.dart';

Password getTodoByIndex(AppState state, int index) => state.passwordList![index];

Password? getTodoById(AppState state, int passwordId) => state.passwordList?.singleWhere((element) => element.id == passwordId);
