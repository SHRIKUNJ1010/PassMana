/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:passmana/presentation/common/custom_bottom_navigation_bar.dart';
import 'package:passmana/utility/constants.dart';
import 'package:passmana/utility/utility.dart';

class NavigationBarScreen extends StatefulWidget {
  final Widget child;

  const NavigationBarScreen({
    super.key,
    required this.child,
  });

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: CustomBottomNavigationBar(
              routeList: AppConstants.bottomNavigationRouteList,
              notSelectedIconWidgets: AppConstants.bottomNavigationNotSelectedIconWidgets,
              notSelectedTextWidgets: AppConstants.bottomNavigationNotSelectedTextWidgets,
              selectedIconWidgets: AppConstants.bottomNavigationSelectedIconWidgets,
              selectedTextWidgets: AppConstants.bottomNavigationSelectedTextWidgets,
              selectedIndex: Utility.getCurrentIndex(),
            ),
          ),
        ],
      ),
    );
  }
}
