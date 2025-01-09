/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';

class CommonContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CommonContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Theme.of(context).cardColor,
      ),
      margin: margin,
      padding: padding ?? EdgeInsets.fromLTRB(10, 7, 10, 7),
      child: child,
    );
  }
}
