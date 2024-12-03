import 'package:flutter/widgets.dart';

enum ScreenDimension {
  mobile(600),
  tablet(900);

  final int value;

  const ScreenDimension(this.value);
}

double dw(BuildContext context) => MediaQuery.of(context).size.width;
double dh(BuildContext context) => MediaQuery.of(context).size.height;

Orientation deviceOrientation(BuildContext context) => MediaQuery.of(context).orientation;
bool isPortrait(BuildContext context) => deviceOrientation(context) == Orientation.portrait;
bool isLandscape(BuildContext context) => deviceOrientation(context) == Orientation.landscape;

bool isMobile(BuildContext context) =>
  (deviceOrientation(context) == Orientation.portrait && dw(context) <= ScreenDimension.mobile.value) ||
  (deviceOrientation(context) == Orientation.landscape && dh(context) <= ScreenDimension.mobile.value);

bool isTablet(BuildContext context) => 
  !isMobile(context) && 
  ((deviceOrientation(context) == Orientation.portrait && dw(context) <= ScreenDimension.tablet.value) ||
  (deviceOrientation(context) == Orientation.landscape && dh(context) <= ScreenDimension.tablet.value));

bool isDesktop(BuildContext context) =>
  deviceOrientation(context) == Orientation.landscape && dw(context) >= ScreenDimension.tablet.value;

extension PercentageSize on num {
  double w(BuildContext context) => dw(context) * (this / 100);
  double h(BuildContext context) => dw(context) * (this / 100);
}
