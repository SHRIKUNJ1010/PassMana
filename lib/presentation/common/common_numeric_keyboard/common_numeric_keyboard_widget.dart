/*
Created By Shrikunj on 07/01/25
*/

import 'package:flutter/material.dart';
import 'package:passmana/localization/app_localization.dart';

import 'common_numeric_keyboard_tile.dart';

class CommonNumericKeyboardWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool disableBottomLeft;
  final bool disableBottomRight;
  final Widget bottomLeftButtonChild;
  final Widget bottomRightButtonChild;
  final Function onBottomLeftButtonTap;
  final Function onBottomRightButtonTap;
  final BuildContext context;

  const CommonNumericKeyboardWidget({
    super.key,
    required this.controller,
    required this.disableBottomLeft,
    required this.disableBottomRight,
    required this.bottomLeftButtonChild,
    required this.bottomRightButtonChild,
    required this.onBottomLeftButtonTap,
    required this.onBottomRightButtonTap,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
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
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '1';
                  },
                  child: Text(
                    getTranslated('1', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '2';
                  },
                  child: Text(
                    getTranslated('2', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '3';
                  },
                  child: Text(
                    getTranslated('3', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '4';
                  },
                  child: Text(
                    getTranslated('4', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '5';
                  },
                  child: Text(
                    getTranslated('5', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '6';
                  },
                  child: Text(
                    getTranslated('6', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '7';
                  },
                  child: Text(
                    getTranslated('7', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '8';
                  },
                  child: Text(
                    getTranslated('8', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '9';
                  },
                  child: Text(
                    getTranslated('9', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
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
                    : CommonNumericKeyboardTile(
                        onTap: onBottomLeftButtonTap,
                        child: bottomLeftButtonChild,
                      ),
                CommonNumericKeyboardTile(
                  onTap: () {
                    controller.text += '0';
                  },
                  child: Text(
                    getTranslated('0', context),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.normal),
                  ),
                ),
                disableBottomRight
                    ? const Spacer(flex: 1)
                    : CommonNumericKeyboardTile(
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
}
