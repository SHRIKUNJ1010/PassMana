/*
* Created by Shrikunj Patel on 1/16/2024.
*/

import 'package:flutter/material.dart';

class CommonConfirmationDialog extends StatelessWidget {
  final Color? bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final double circularBorderRadius;

  const CommonConfirmationDialog({
    super.key,
    this.title = '',
    this.message = '',
    this.circularBorderRadius = 3,
    this.bgColor,
    this.positiveBtnText = 'Yes',
    this.negativeBtnText = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
      ),
      backgroundColor: bgColor ?? Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            negativeBtnText,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            positiveBtnText,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
