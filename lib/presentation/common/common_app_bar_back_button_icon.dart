/*
Created By Shrikunj on 10/01/25
*/

import 'package:flutter/material.dart';

class CommonAppBarBackButtonIcon extends StatelessWidget {
  const CommonAppBarBackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back,
      color: Theme.of(context).appBarTheme.iconTheme?.color,
      size: 25,
    );
  }
}
