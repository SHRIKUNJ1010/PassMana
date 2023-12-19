/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

class HomeGroupGridTile extends StatelessWidget {
  final Group group;
  final Function onTap;

  const HomeGroupGridTile({
    required this.group,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: AppColors.mWhite,
        child: InkWell(
          onTap: () {
            onTap.call();
          },
          splashColor: AppColors.secondaryColor.withOpacity(0.2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    group.groupName.trim()[0].toUpperCase(),
                    style: TextStyles.getBoldWhiteText(34),
                  ),
                ),
                Text(
                  group.groupName,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getBoldRedText(18),
                ),
                const SizedBox(height: 5),
                Text(
                  "Passwords: ${group.passwords.length}",
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getBoldRedText(16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
