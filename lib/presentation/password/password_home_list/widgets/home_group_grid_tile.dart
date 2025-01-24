/*
* Created by Shrikunj Patel on 12/19/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/model/group_model.dart';
import 'package:passmana/utility/constants.dart';

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
      borderRadius: BorderRadius.circular(6),
      child: Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            onTap.call();
          },
          splashColor: Theme.of(context).textTheme.displayLarge?.color?.withValues(alpha: 0.2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Hero(
                    tag: "${AppConstants.groupHero}${group.id}",
                    child: Text(
                      group.groupName.trim()[0].toUpperCase(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 34),
                    ),
                  ),
                ),
                Text(
                  group.groupName,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Passwords: ${group.passwords.length}",
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
