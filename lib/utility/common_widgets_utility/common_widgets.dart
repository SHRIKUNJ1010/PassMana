/*
* Created by Shrikunj Patel on 11/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';

class CommonWidgets {
  static Widget getCommonButtonWithSplash({
    required BuildContext context,
    required double height,
    required Function onTap,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.displayLarge?.color,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: AppColors.accentSecondaryColor,
          onTap: () {
            onTap.call();
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.mWhite,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget getCommonHiddenPinFieldFilledText() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.mWhite,
          ),
        ),
      ),
    );
  }

  static Widget getCommonHiddenPinFieldEmptyText() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.mWhite,
              width: 1.7,
            ),
          ),
        ),
      ),
    );
  }

  static Widget getCommonHiddenPinField({
    required TextEditingController controller,
  }) {
    if (controller.text.length > 6) return const SizedBox();
    int filledCount = controller.text.length;
    int notFilledCount = 6 - (controller.text.length);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 30,
        maxWidth: 270,
      ),
      child: Row(
        children: [
          for (int i = 0; i < filledCount; i++) ...[
            getCommonHiddenPinFieldFilledText(),
          ],
          for (int j = 0; j < notFilledCount; j++) ...[
            getCommonHiddenPinFieldEmptyText(),
          ],
        ],
      ),
    );
  }

  static Widget getBottomBarNotSelectedTile({
    required Widget iconWidget,
    required Widget textWidget,
    required Function onTap,
  }) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppColors.accentPrimaryColor,
            onTap: () {
              onTap.call();
            },
            child: SizedBox(
              height: 54,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 24,
                    child: OverflowBox(
                      maxHeight: 24,
                      minHeight: 24,
                      alignment: Alignment.center,
                      child: iconWidget,
                    ),
                  ),
                  const SizedBox(height: 5),
                  textWidget,
                  const SizedBox(height: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget getBottomBarSelectedTile({
    required Widget iconWidget,
    required Widget textWidget,
  }) {
    return Expanded(
      child: SizedBox(
        height: 54,
        child: Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              height: 24,
              child: OverflowBox(
                maxHeight: 24,
                minHeight: 24,
                alignment: Alignment.center,
                child: iconWidget,
              ),
            ),
            const SizedBox(height: 5),
            textWidget,
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  static Widget getBottomBarCenterSelectedTile({
    required Widget iconWidget,
    required Widget textWidget,
    required BuildContext context,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.displayLarge!.color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: iconWidget,
          ),
          const SizedBox(height: 10),
          textWidget,
          const SizedBox(height: 2),
        ],
      ),
    );
  }

  static Widget getBottomBarCenterNotSelectedTile({
    required Widget iconWidget,
    required Widget textWidget,
    required Function onTap,
    required BuildContext context,
  }) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppColors.accentPrimaryColor,
            onTap: () {
              onTap.call();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: iconWidget,
                ),
                const SizedBox(height: 10),
                textWidget,
                const SizedBox(height: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
