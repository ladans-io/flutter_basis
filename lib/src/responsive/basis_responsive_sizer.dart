import 'package:flutter/widgets.dart';

enum ScreenDimension {
  mobile(599),
  tablet(899);

  final int value;

  const ScreenDimension(this.value);
}

double dw(BuildContext context) => MediaQuery.of(context).size.width;
double dh(BuildContext context) => MediaQuery.of(context).size.height;

bool isMobile(BuildContext context) => dw(context) <= ScreenDimension.mobile.value;
bool isTablet(BuildContext context) => !isMobile(context) && dw(context) <= ScreenDimension.tablet.value;
bool isDesktop(BuildContext context) => !isMobile(context) && !isTablet(context);

extension PercentageSize on num {
  double w(BuildContext context) => dw(context) * (this/100);
  double h(BuildContext context) => dw(context) * (this/100);
}