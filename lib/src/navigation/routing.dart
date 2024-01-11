import 'package:flutter/material.dart';

import 'basis_route.dart';
import 'transition.dart';

mixin Routing {
  String get initialRoute => '/';
  Map<String, BasisRoute> get routes;

  Widget _transitionBuilder(
    BuildContext context,
    Animation<double> anim,
    Animation<double> secondAnim,
    child, {
    TransitionType? transitionType,
  }) =>
    switch (transitionType) {
      TransitionType.upToDown => upToDown(anim, child),
      TransitionType.downToUp => downToUp(anim, child),
      TransitionType.leftToRight => leftToRight(anim, child),
      TransitionType.rightToLeft => rightToLeft(anim, child),
      TransitionType.leftToRightFaded => leftToRightFaded(anim, child),
      TransitionType.rightToLeftFaded => rightToLeftFaded(anim, child),
      TransitionType.rotate => rotate(anim, child),
      TransitionType.scale => scale(anim, child),
      TransitionType.scaleElasticIn => scaleElasticIn(anim, child),
      TransitionType.scaleElasticInOut => scaleElasticInOut(anim, child),
      TransitionType.size => size(anim, child),
      TransitionType.fadeIn => fadeIn(anim, child),
      TransitionType.noTransition => child,      
      _ => rightToLeft(anim, child)
    };

  Route? onGenerateRoute(RouteSettings routerSettings) {
    var routerName = routerSettings.name;
    var routerArgs = routerSettings.arguments;

    var navigateTo = routes[routerName]?.widgetBuilderArgs;

    var transitionType = routes[routerName]?.transitionType;
    var transitionDuration = routes[routerName]?.transitionDuration;
    var reverseTransitionDuration = routes[routerName]?.reverseTransitionDuration;

    if (navigateTo == null) return null;

    return PageRouteBuilder(
      pageBuilder: (context, anim, secondAnim) {
        return navigateTo(context, routerArgs);
      },
      transitionDuration: transitionDuration ??= const Duration(milliseconds: 300),
      reverseTransitionDuration: reverseTransitionDuration ??= const Duration(milliseconds: 300),
      transitionsBuilder: (context, anim, secondAnim, child) {
        return _transitionBuilder(
          context,
          anim,
          secondAnim,
          child,
          transitionType: transitionType ?? TransitionType.rightToLeft,
        );
      },
    );
  }
}
