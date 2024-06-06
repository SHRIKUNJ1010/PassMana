/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/filter_search/filter_search_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';
import 'package:passmana/utility/utility.dart';

class FilterSearchScreen extends StatelessWidget {
  const FilterSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FilterSearchViewModel>(
      converter: FilterSearchViewModel.fromStore,
      builder: (BuildContext context, FilterSearchViewModel vm) {
        return Container(
          decoration: Utility.getCommonBackgroundDecoration(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: getAppBar(vm, context),
          ),
        );
      },
    );
  }

  CustomAppBar getAppBar(FilterSearchViewModel vm, BuildContext context) {
    return CustomAppBar(
      centerWidgetsList: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: AppColors.mWhite,
                  child: InkWell(
                    splashColor: AppColors.mBlack.withOpacity(0.2),
                    onTap: () {
                      vm.onBackPress.call();
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          getTranslated("filter_search", context),
          style: TextStyles.getTitleWhiteText(25),
        ),
        const Spacer(),
      ],
    );
  }
}
