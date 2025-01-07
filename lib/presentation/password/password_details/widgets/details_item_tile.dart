/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/presentation/common/common_container_widget.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class DetailsItemTile extends StatelessWidget {
  final String title;
  final String description;
  final Widget? actionItem;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const DetailsItemTile({
    super.key,
    required this.title,
    required this.description,
    this.actionItem,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return CommonContainerWidget(
      margin: margin,
      padding: padding,
      child: actionItem != null
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyles.getTitleDarkRedText(17),
                      ),
                      Text(
                        description,
                        maxLines: 5,
                        softWrap: true,
                        style: TextStyles.getTitleTransparentBlackText(
                          fontSize: 17,
                          opacity: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                actionItem!,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.getTitleDarkRedText(17),
                ),
                Text(
                  description,
                  maxLines: 5,
                  softWrap: true,
                  style: TextStyles.getTitleTransparentBlackText(
                    fontSize: 17,
                    opacity: 1,
                  ),
                ),
              ],
            ),
    );
  }
}
