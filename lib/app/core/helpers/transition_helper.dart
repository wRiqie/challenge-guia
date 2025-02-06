import 'package:flutter/material.dart';

class TransitionHelper {
  TransitionHelper._();

  static Route showModal(Widget modal, [Object? args]) {
    return PageRouteBuilder(
      settings: args != null ? RouteSettings(arguments: args) : null,
      pageBuilder: (context, animation, secondaryAnimation) {
        return modal;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
