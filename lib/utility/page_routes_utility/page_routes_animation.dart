/*
* Created by Shrikunj Patel on 8/24/2023.
*/

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation.drive(CurveTween(curve: Curves.easeIn)), child: child),
        );
}

class SlideTransitionPage extends CustomTransitionPage<void> {
  SlideTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation), child: child),
        );
}

class SlideRightTransitionPage extends CustomTransitionPage<void> {
  SlideRightTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation), child: child),
        );
}

class SizeTransitionPage extends CustomTransitionPage<void> {
  SizeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(child: SizeTransition(sizeFactor: animation, child: child)),
        );
}

class ScaleTransitionPage extends CustomTransitionPage<void> {
  ScaleTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)), child: child),
        );
}
