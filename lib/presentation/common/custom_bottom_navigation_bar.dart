/*
* Created by Shrikunj Patel on 11/29/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/utility/common_widgets_utility/common_widgets.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<Widget> notSelectedIconWidgets;
  final List<Widget> notSelectedTextWidgets;
  final List<Widget> selectedIconWidgets;
  final List<Widget> selectedTextWidgets;
  final List<String> routeList;
  final int selectedIndex;
  final Function(int) onItemTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.routeList,
    required this.notSelectedIconWidgets,
    required this.notSelectedTextWidgets,
    required this.selectedIconWidgets,
    required this.selectedTextWidgets,
    required this.selectedIndex,
    required this.onItemTap,
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
          height: 95 + MediaQuery.paddingOf(context).bottom,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 65 + MediaQuery.paddingOf(context).bottom,
            padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.paddingOf(context).bottom + 5,
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
                            context: context,
                          )
                        : CommonWidgets.getBottomBarSelectedTile(
                            iconWidget: widget.selectedIconWidgets[i],
                            textWidget: widget.selectedTextWidgets[i],
                          )
                    : i == 2
                        ? CommonWidgets.getBottomBarCenterNotSelectedTile(
                            iconWidget: widget.notSelectedIconWidgets[i],
                            textWidget: widget.notSelectedTextWidgets[i],
                            context: context,
                            onTap: () {
                              widget.onItemTap.call(i);
                            },
                          )
                        : CommonWidgets.getBottomBarNotSelectedTile(
                            iconWidget: widget.notSelectedIconWidgets[i],
                            textWidget: widget.notSelectedTextWidgets[i],
                            onTap: () {
                              widget.onItemTap.call(i);
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
