/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/presentation/common/custom_app_bar.dart';
import 'package:passmana/presentation/password/password_list/password_list_view_model.dart';
import 'package:passmana/presentation/password/password_list/search_password_widget.dart';
import 'package:passmana/utility/assets_utility/assets_paths.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class PasswordListScreen extends StatelessWidget {
  const PasswordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PasswordListViewModel>(
      converter: PasswordListViewModel.fromStore,
      builder: (BuildContext context, PasswordListViewModel vm) {
        final double width = MediaQuery.of(context).size.width;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.10, 0.90],
              colors: [
                AppColors.accentPrimaryColor.withOpacity(0.7),
                AppColors.accentSecondaryColor.withOpacity(0.7),
              ],
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              centerWidgetsList: [
                const SizedBox(width: 20),
                SizedBox(
                  width: 40,
                  child: Hero(
                    tag: AppConstants.appLogo,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(AppAssets.appLogoWithoutText),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  getTranslated("password"),
                  style: TextStyles.getTitleWhiteText(28),
                ),
                const Spacer(),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 7),
                      child: Text(
                        getTranslated("hello_user,"),
                        softWrap: true,
                        style: TextStyles.getBoldRedText(26),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text(
                        getTranslated("find_your_password"),
                        softWrap: true,
                        style: TextStyles.getTitleWhiteText(22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: SearchPasswordWidget(
                        onChange: (val) {},
                        onSubmit: (val) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated("popular_groups"),
                            softWrap: true,
                            style: TextStyles.getBoldWhiteText(26),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                splashColor: AppColors.mWhite.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  child: Text(
                                    getTranslated("see_all"),
                                    softWrap: true,
                                    style: TextStyles.getTitleDarkRedText(24),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: SizedBox(
                        width: width - 40,
                        height: width - 40,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int i = 0; i < 4; i++) ...[
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.mWhite,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'M',
                                        style: TextStyles.getBoldWhiteText(34),
                                      ),
                                    ),
                                    Text(
                                      "My Passwords",
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.getBoldRedText(18),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Passwords: 16",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.getBoldRedText(16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated("recently_added"),
                            softWrap: true,
                            style: TextStyles.getBoldWhiteText(26),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                splashColor: AppColors.mWhite.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  child: Text(
                                    getTranslated("see_all"),
                                    softWrap: true,
                                    style: TextStyles.getTitleBlueText(24),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (int i = 0; i < 10; i++) ...[
                          Container(
                            height: 75,
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            decoration: BoxDecoration(
                              color: AppColors.mWhite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'M',
                                    style: TextStyles.getBoldWhiteText(27),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "My Passwords",
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyles.getTitleBlueText(20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: AppColors.mBlack.withOpacity(0.2),
                                        onTap: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.copy,
                                            color: AppColors.primaryColor,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
