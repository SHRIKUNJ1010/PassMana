/*
* Created by Shrikunj Patel on 11/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CommonWidgets {
  static Widget getCommonButtonWithSplash({
    required BuildContext context,
    required double height,
    required Function onTap,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: height,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.accentSecondaryColor,
          onTap: () {
            onTap.call();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyles.getButtonWhiteText(16),
            ),
          ),
        ),
      ),
    );
  }
}
