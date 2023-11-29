/*
* Created by Shrikunj Patel on 11/29/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/color.dart';
import 'package:passmana/utility/common_widgets_utility/common_widgets.dart';
import 'package:passmana/utility/utility.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<Widget> notSelectedIconWidgets;
  final List<Widget> notSelectedTextWidgets;
  final List<Widget> selectedIconWidgets;
  final List<Widget> selectedTextWidgets;
  final List<String> routeList;
  final int selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.routeList,
    required this.notSelectedIconWidgets,
    required this.notSelectedTextWidgets,
    required this.selectedIconWidgets,
    required this.selectedTextWidgets,
    required this.selectedIndex,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 90,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 10,
          left: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < 5; i++) ...[
                widget.selectedIndex == i
                    ? i == 2
                        ? CommonWidgets.getBottomBarCenterSelectedTile(
                            iconWidget: widget.selectedIconWidgets[i],
                            textWidget: widget.selectedTextWidgets[i],
                          )
                        : CommonWidgets.getBottomBarSelectedTile(
                            iconWidget: widget.selectedIconWidgets[i],
                            textWidget: widget.selectedTextWidgets[i],
                          )
                    : i == 2
                        ? CommonWidgets.getBottomBarCenterNotSelectedTile(
                            iconWidget: widget.notSelectedIconWidgets[i],
                            textWidget: widget.notSelectedTextWidgets[i],
                            onTap: () {
                              Utility.bottomBarOnTap(i);
                            })
                        : CommonWidgets.getBottomBarNotSelectedTile(
                            iconWidget: widget.notSelectedIconWidgets[i],
                            textWidget: widget.notSelectedTextWidgets[i],
                            onTap: () {
                              Utility.bottomBarOnTap(i);
                            },
                          ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
