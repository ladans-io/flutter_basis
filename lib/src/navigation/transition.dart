import 'package:flutter/widgets.dart';

enum TransitionType {
  defaultTransition,
  fadeIn,
  noTransition,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  scaleElasticIn,
  scaleElasticInOut,
  rotate,
  size,
  rightToLeftFaded,
  leftToRightFaded,
}

const _end = Offset.zero;

Widget leftToRight(
  Animation<double> anim, 
  Widget child,
) {

  const begin = Offset(-1.0, 0.0);
  final parent = CurveTween(curve: Curves.easeIn);

  final tween = Tween(begin: begin, end: _end).chain(parent);
  final offsetAnimation = anim.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget rightToLeft(
  Animation<double> anim, 
  Widget child,
) {

  const begin = Offset(1.0, 0.0);
  final parent = CurveTween(curve: Curves.easeIn);

  final tween = Tween(begin: begin, end: _end).chain(parent);
  final offsetAnimation = anim.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget leftToRightFaded(
  Animation<double> anim, 
  Widget child,
) {

  const begin = Offset(-1.0, 0.0);
  final parent = CurveTween(curve: Curves.easeIn);

  final tween = Tween(begin: begin, end: _end).chain(parent);
  final offsetAnimation = anim.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: FadeTransition(opacity: anim, child: child),
  );
}

Widget rightToLeftFaded(
  Animation<double> anim, 
  Widget child,
) {

  const begin = Offset(1.0, 0.0);
  final parent = CurveTween(curve: Curves.easeIn);

  final tween = Tween(begin: begin, end: _end).chain(parent);
  final offsetAnimation = anim.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: FadeTransition(opacity: anim, child: child),
  );
}

Widget upToDown(
  Animation<double> anim, 
  Widget child,
) {

  const begin = Offset(0.0, -1.0);
  final parent = CurveTween(curve: Curves.easeIn);

  final tween = Tween(begin: begin, end: _end).chain(parent);
  final offsetAnimation = anim.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget downToUp(
  Animation<double> anim, 
  Widget child,
) {

  const begin = Offset(0.0, 1.0);
  final parent = CurveTween(curve: Curves.easeIn);

  final tween = Tween(begin: begin, end: _end).chain(parent);
  final offsetAnimation = anim.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

Widget fadeIn(
  Animation<double> anim, 
  Widget child,
) {
  return FadeTransition(opacity: anim, child: child);
}

Widget rotate(
  Animation<double> anim, 
  Widget child,
) {
  return RotationTransition(
    turns: anim,
    child: child,
  );
}

Widget size(
  Animation<double> anim, 
  Widget child,
) {
  return SizeTransition(
    sizeFactor: anim,
    child: child,
  );
}

Widget scale(
  Animation<double> anim, 
  Widget child,
) {
  return ScaleTransition(
    scale: anim,
    alignment: Alignment.center,
    child: child,
  );
}

Widget scaleElasticIn(
  Animation<double> anim, 
  Widget child,
) {
  return ScaleTransition(
    scale: CurvedAnimation(parent: anim, curve: Curves.elasticIn),
    alignment: Alignment.center,
    child: child,
  );
}

Widget scaleElasticInOut(
  Animation<double> anim, 
  Widget child,
) {
  return ScaleTransition(
    scale: CurvedAnimation(parent: anim, curve: Curves.elasticInOut),
    alignment: Alignment.center,
    child: child,
  );
}