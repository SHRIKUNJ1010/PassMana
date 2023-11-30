/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/common/custom_bottom_navigation_bar.dart';
import 'package:passmana/presentation/navigation_bar/navigation_bar_view_model.dart';

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
    return StoreConnector<AppState, NavigationBarViewModel>(
      converter: NavigationBarViewModel.fromStore,
      builder: (BuildContext context, NavigationBarViewModel vm) {
        return Scaffold(
          body: Stack(
            children: [
              widget.child,
              Positioned(
                bottom: 10,
                right: 10,
                left: 10,
                child: CustomBottomNavigationBar(
                  routeList: vm.routeList,
                  notSelectedIconWidgets: vm.notSelectedIconWidgets,
                  notSelectedTextWidgets: vm.notSelectedTextWidgets,
                  selectedIconWidgets: vm.selectedIconWidgets,
                  selectedTextWidgets: vm.selectedTextWidgets,
                  selectedIndex: vm.getCurrentIndex.call(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}