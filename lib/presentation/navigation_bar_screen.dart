/*
* Created by Shrikunj Patel on 9/12/2023.
*/

import 'package:flutter/material.dart';

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
      body: widget.child,
      //todo: bottom navigation bar
    );
  }
}
