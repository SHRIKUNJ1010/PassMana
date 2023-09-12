/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:redux/redux.dart';

class CreateUpdateGroupViewModel {
  CreateUpdateGroupViewModel();

  static CreateUpdateGroupViewModel fromStore(Store<AppState> store) {
    return CreateUpdateGroupViewModel();
  }
}
