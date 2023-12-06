/*
* Created by Shrikunj Patel on 11/30/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/create_list/create_list_item_widget.dart';
import 'package:passmana/presentation/create_list/create_list_view_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CreateListScreen extends StatelessWidget {
  const CreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CreateListViewModel>(
      converter: CreateListViewModel.fromStore,
      builder: (BuildContext context, CreateListViewModel vm) {
        final double height = MediaQuery.of(context).size.height;
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    getTranslated("store_your_data"),
                    softWrap: true,
                    style: TextStyles.getTitleDarkRedText(40),
                  ),
                ),
                Container(
                  height: 0.6 * height,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: CreateListItemTile(
                                onTap: () {},
                                title: getTranslated("password"),
                                icon: Icon(
                                  Icons.lock,
                                  color: AppColors.mWhite.withOpacity(0.6),
                                  size: 50,
                                ),
                              ),
                            ),
                            Expanded(
                              child: CreateListItemTile(
                                onTap: () {},
                                title: getTranslated("group"),
                                icon: Icon(
                                  Icons.people,
                                  color: AppColors.mWhite.withOpacity(0.6),
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: CreateListItemTile(
                                onTap: () {},
                                title: getTranslated("card"),
                                icon: Icon(
                                  Icons.credit_card,
                                  color: AppColors.mWhite.withOpacity(0.6),
                                  size: 50,
                                ),
                              ),
                            ),
                            Expanded(
                              child: CreateListItemTile(
                                onTap: () {},
                                title: getTranslated("secret_note"),
                                icon: Icon(
                                  Icons.note_alt,
                                  color: AppColors.mWhite.withOpacity(0.6),
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
