/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CommonBottomButton extends StatelessWidget {
  final String title;
  final Function() onItemTap;

  const CommonBottomButton({
    super.key,
    required this.title,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12),
      ),
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        child: InkWell(
          splashColor: AppColors.mWhite.withValues(alpha: 0.2),
          onTap: onItemTap,
          child: Container(
            height: 65 + MediaQuery.paddingOf(context).bottom,
            padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyles.getTitleWhiteText(24),
            ),
          ),
        ),
      ),
    );
  }
}
