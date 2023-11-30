/*
* Created by Shrikunj Patel on 11/24/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/text_utility/text_styles.dart';

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
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
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
              style: TextStyles.getButtonWhiteText(16),
            ),
          ),
        ),
      ),
    );
  }

  static Widget getCommonNumericKeyboardTile({
    required Function onTap,
    required Widget child,
  }) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onTap.call();
              },
              splashColor: AppColors.accentPrimaryColor,
              child: Container(
                alignment: Alignment.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget getCommonNumericKeyboard({
    required TextEditingController controller,
    required bool disableBottomLeft,
    required bool disableBottomRight,
    required Widget bottomLeftButtonChild,
    required Widget bottomRightButtonChild,
    required Function onBottomLeftButtonTap,
    required Function onBottomRightButtonTap,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 330,
        maxHeight: 400,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '1';
                  },
                  child: Text(
                    getTranslated('1'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '2';
                  },
                  child: Text(
                    getTranslated('2'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '3';
                  },
                  child: Text(
                    getTranslated('3'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '4';
                  },
                  child: Text(
                    getTranslated('4'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '5';
                  },
                  child: Text(
                    getTranslated('5'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '6';
                  },
                  child: Text(
                    getTranslated('6'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '7';
                  },
                  child: Text(
                    getTranslated('7'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '8';
                  },
                  child: Text(
                    getTranslated('8'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '9';
                  },
                  child: Text(
                    getTranslated('9'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                disableBottomLeft
                    ? const Spacer(flex: 1)
                    : getCommonNumericKeyboardTile(
                        onTap: onBottomLeftButtonTap,
                        child: bottomLeftButtonChild,
                      ),
                getCommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '0';
                  },
                  child: Text(
                    getTranslated('0'),
                    style: TextStyles.getButtonWhiteText(32),
                  ),
                ),
                disableBottomRight
                    ? const Spacer(flex: 1)
                    : getCommonNumericKeyboardTile(
                        onTap: onBottomRightButtonTap,
                        child: bottomRightButtonChild,
                      ),
              ],
            ),
          ),
        ],
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
              height: 50,
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
        height: 50,
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
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.secondaryMaterialColor[400],
              borderRadius: BorderRadius.circular(30),
            ),
            child: iconWidget,
          ),
          const SizedBox(height: 5),
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
                    color: AppColors.secondaryMaterialColor[400],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: iconWidget,
                ),
                const SizedBox(height: 5),
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
