/*
* Created by Shrikunj Patel on 12/8/2023.
*/

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> centerWidgetsList;
  final Widget? leadingWidget;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.centerWidgetsList,
    this.leadingWidget,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      elevation: 5,
      toolbarHeight: preferredSize.height,
      titleSpacing: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: centerWidgetsList,
      ),
      automaticallyImplyLeading: false,
      leading: leadingWidget,
      actions: actions,
    );
  }
}
