/*
* Created by Shrikunj Patel on 12/21/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class GroupListTile extends StatelessWidget {
  final Group group;
  final Function onTap;

  const GroupListTile({
    required this.group,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: AppColors.mWhite,
        child: InkWell(
          splashColor: AppColors.primaryColor.withValues(alpha: 0.2),
          onTap: () {
            onTap.call();
          },
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    group.groupName.trim()[0].toUpperCase(),
                    style: TextStyles.getBoldWhiteText(27),
                  ),
                ),
                Expanded(
                  child: Text(
                    group.groupName,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.getTitleBlueText(20),
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
