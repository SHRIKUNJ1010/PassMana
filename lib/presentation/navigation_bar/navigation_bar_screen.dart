/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:passmana/domain_redux/app_state.dart';
import 'package:passmana/presentation/common/custom_bottom_navigation_bar.dart';
import 'package:passmana/presentation/navigation_bar/navigation_bar_view_model.dart';
import 'package:redux/redux.dart';

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
      converter: (Store<AppState> store) {
        return NavigationBarViewModel.fromStore(store, context);
      },
      builder: (BuildContext context, NavigationBarViewModel vm) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              widget.child,
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: CustomBottomNavigationBar(
                  routeList: vm.routeList,
                  notSelectedIconWidgets: vm.notSelectedIconWidgets,
                  notSelectedTextWidgets: vm.notSelectedTextWidgets,
                  selectedIconWidgets: vm.selectedIconWidgets,
                  selectedTextWidgets: vm.selectedTextWidgets,
                  selectedIndex: vm.getCurrentIndex.call(),
                  onItemTap: vm.onItemTap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
