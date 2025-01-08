/*
* Created by Shrikunj Patel on 12/4/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class CreateListItemTile extends StatelessWidget {
  final String title;
  final String heroTag;
  final Widget icon;
  final Function onTap;

  const CreateListItemTile({
    super.key,
    required this.title,
    required this.heroTag,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Material(
          elevation: 5,
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {
              onTap.call();
            },
            splashColor: AppColors.accentSecondaryColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Theme.of(context).cardColor.withValues(alpha: 0.7),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon,
                    const SizedBox(height: 5),
                    Hero(
                      tag: heroTag,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
