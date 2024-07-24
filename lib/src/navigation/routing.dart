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
    Widget child, {
    TransitionType? transitionType,
  }) =>
    switch (transitionType) {
      TransitionType.upToDown => upToDown(anim, child),
      TransitionType.downToUp => downToUp(anim, child),
      TransitionType.leftToRight => leftToRight(anim, secondAnim, child),
      TransitionType.rightToLeft => rightToLeft(anim, secondAnim, child),
      TransitionType.leftToRightFaded => leftToRightFaded(anim, secondAnim, child),
      TransitionType.rightToLeftFaded => rightToLeftFaded(anim, secondAnim, child),
      TransitionType.rotate => rotate(anim, child),
      TransitionType.scale => scale(anim, child),
      TransitionType.scaleElasticIn => scaleElasticIn(anim, child),
      TransitionType.scaleElasticInOut => scaleElasticInOut(anim, child),
      TransitionType.size => size(anim, child),
      TransitionType.fadeIn => fadeIn(anim, child),
      TransitionType.noTransition => child,      
      _ => rightToLeft(anim, secondAnim, child)
    };

  Route? onGenerateRoute(
    RouteSettings routerSettings, [
    Map<String, BasisRoute>? nestedRoutes,
  ]) {
    final routerName = routerSettings.name;
    final routerArgs = routerSettings.arguments;

    final rts = nestedRoutes ?? routes;
    final navigateTo = rts[routerName]?.widgetBuilderArgs;

    final transitionType = rts[routerName]?.transitionType;
    var transitionDuration = rts[routerName]?.transitionDuration;
    var reverseTransitionDuration = rts[routerName]?.reverseTransitionDuration;

    if (navigateTo == null) return null;

    return PageRouteBuilder(
      pageBuilder: (context, anim, secondAnim) => navigateTo(context, routerArgs),
      transitionDuration: transitionDuration ??= const Duration(milliseconds: 300),
      reverseTransitionDuration: reverseTransitionDuration ??= const Duration(milliseconds: 300),
      transitionsBuilder: (context, anim, secondAnim, child) {
        return _transitionBuilder(context, anim, secondAnim, child, transitionType: transitionType ?? TransitionType.rightToLeft);
      },
    );
  }
}
