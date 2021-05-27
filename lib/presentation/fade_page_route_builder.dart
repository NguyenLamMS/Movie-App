import 'package:flutter/cupertino.dart';

class FadePageRouteBuilder<T> extends PageRouteBuilder<T> {
  final WidgetBuilder widgetBuilder;
  final RouteSettings routeSettings;

  FadePageRouteBuilder({@required this.widgetBuilder, @required this.routeSettings})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => widgetBuilder(context),
            transitionsBuilder: (context, animation, secondAnimation, child) {
              var curve = Curves.ease;
              var tween = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: curve));
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
            settings: routeSettings);
}
