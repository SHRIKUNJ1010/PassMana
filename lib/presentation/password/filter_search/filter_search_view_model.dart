/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:passmana/domain_redux/app_state.dart';
import 'package:redux/redux.dart';

class FilterSearchViewModel {
  FilterSearchViewModel();

  static FilterSearchViewModel fromStore(Store<AppState> store) {
    return FilterSearchViewModel();
  }
}
