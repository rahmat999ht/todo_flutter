import 'package:flutter/material.dart';

class PageNavigationOpacity<T> extends MaterialPageRoute<T> {
  PageNavigationOpacity({
    required WidgetBuilder builder,
  }) : super(
          builder: builder,
        );

  static toPage(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      PageNavigationOpacity(builder: (context) => widget),
    );
  }

  static toPageReplacement(BuildContext context, Widget widget) {
    Navigator.of(context).pushReplacement(
      PageNavigationOpacity(builder: (context) => widget),
    );
  }

  @override
  Widget buildTransitions(context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
