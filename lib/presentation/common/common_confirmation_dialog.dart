/*
* Created by Shrikunj Patel on 1/16/2024.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class CommonConfirmationDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final double circularBorderRadius;

  const CommonConfirmationDialog({
    super.key,
    this.title = '',
    this.message = '',
    this.circularBorderRadius = 10,
    this.bgColor = Colors.white,
    this.positiveBtnText = 'Yes',
    this.negativeBtnText = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyles.getTitleTransparentBlackCustomWeightText(
          fontSize: 16,
          opacity: 1,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        message,
        style: TextStyles.getTitleTransparentBlackCustomWeightText(
          fontSize: 16,
          opacity: 1,
          fontWeight: FontWeight.normal,
        ),
      ),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            negativeBtnText,
            style: TextStyles.getTitleBlueText(16),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            positiveBtnText,
            style: TextStyles.getTitleBlueText(16),
          ),
        ),
      ],
    );
  }
}
