/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class CommonAppBarActionIconButton extends StatelessWidget {
  final Function() onItemTap;
  final Widget icon;
  final EdgeInsetsGeometry? iconPadding;
  final Color? buttonColor;
  final Color? buttonSplashColor;

  const CommonAppBarActionIconButton({
    super.key,
    required this.onItemTap,
    required this.icon,
    this.iconPadding,
    this.buttonColor,
    this.buttonSplashColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Material(
        color: buttonColor ?? AppColors.mWhite,
        child: InkWell(
          splashColor: buttonSplashColor ?? AppColors.mBlack.withValues(alpha: 0.2),
          onTap: onItemTap,
          child: Padding(
            padding: iconPadding ?? EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: icon,
          ),
        ),
      ),
    );
  }
}
