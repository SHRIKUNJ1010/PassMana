/*
* Created by Shrikunj Patel on 12/18/2023.
*/

import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class SearchPasswordWidget extends StatelessWidget {
  final Function onTap;

  const SearchPasswordWidget({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: AppColors.mWhite,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          splashColor: AppColors.primaryColor.withOpacity(0.3),
          onTap: () {
            onTap.call();
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated("search_password"),
                                style: TextStyles.getTitleTransparentBlackText(fontSize: 20, opacity: 0.8),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: AppColors.secondaryColor,
                  child: InkWell(
                    splashColor: AppColors.primaryColor.withOpacity(0.3),
                    onTap: () {
                      onTap.call();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        WebSymbols.search,
                        size: 25,
                        color: AppColors.mWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
