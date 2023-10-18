import 'package:flutter/material.dart';

mixin ResponsiveSizes {

  /// Verify if device is a tablet
  bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 750;
  }

  /// Screen width & height
  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Statusbar height
  statusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;

  /// Bottom insets
  viewBottomInsets(BuildContext context) => MediaQuery.of(context).viewInsets.bottom;

  double kRespValue(BuildContext context, double value, double multiplier) {
    return isTablet(context) ? (value * multiplier) : value;
  }

  /// App bar size
  double get appBarHeight => AppBar().preferredSize.height;

  /// Extra small button height
  xSBtn(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 12
      : screenHeight(context) / 12;

  /// Small button height
  sBtn(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 10
      : screenHeight(context) / 10;

  /// Normal button height
  btn(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 9
      : screenHeight(context) / 9;

  /// Large button height
  lBtn(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 7
      : screenHeight(context) / 7;

  /// Extra large button height
  xLBtn(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 5
      : screenHeight(context) / 5;

  /// dynamic button height
  divBtn(BuildContext context, double per) =>
      _orientation(context) == Orientation.portrait
          ? screenWidth(context) / per
          : screenHeight(context) / per;

  /// Calculated button sizes
  /// 
  
  /// 4 pixels button
  dp4(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 100
        : screenHeight(context) / 100;
  }

  /// 5 pixels button
  dp5(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 83
        : screenHeight(context) / 83;
  }

  /// 6 pixels button
  dp6(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 68
        : screenHeight(context) / 68;
  }

  /// 7 pixels button
  dp7(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 60
        : screenHeight(context) / 60;
  }

  /// 8 pixels button
  dp8(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 51
        : screenHeight(context) / 51;
  }

  /// 9 pixels button
  dp9(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 46
        : screenHeight(context) / 46;
  }

  /// 10 pixels button
  dp10(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 41
        : screenHeight(context) / 41;
  }

  /// 11 pixels button
  dp11(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 38
        : screenHeight(context) / 38;
  }

  /// 12 pixels button
  dp12(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 35
        : screenHeight(context) / 35;
  }

  /// 13 pixels button
  dp13(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 32
        : screenHeight(context) / 32;
  }

  /// 14 pixels button
  dp14(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 30
        : screenHeight(context) / 30;
  }

  /// 15 pixels button
  dp15(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 27.5
        : screenHeight(context) / 27.5;
  }

  /// 16 pixels button
  dp16(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 26
        : screenHeight(context) / 26;
  }

  /// 17 pixels button
  dp17(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 24.5
        : screenHeight(context) / 24.5;
  }

  /// 18 pixels button
  dp18(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 23
        : screenHeight(context) / 23;
  }

  /// 19 pixels button
  dp19(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 22
        : screenHeight(context) / 22;
  }

  /// 20 pixels button
  dp20(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 21
        : screenHeight(context) / 21;
  }

  /// 21 pixels button
  dp21(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 20
        : screenHeight(context) / 20;
  }

  /// 22 pixels button
  dp22(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 19
        : screenHeight(context) / 19;
  }

  /// 23 pixels button
  dp23(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 18
        : screenHeight(context) / 18;
  }

  /// 24 pixels button
  dp24(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 17
        : screenHeight(context) / 17;
  }

  /// 25 pixels button
  dp25(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 16.5
        : screenHeight(context) / 16.5;
  }

  /// 26 pixels button
  dp26(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 16
        : screenHeight(context) / 16;
  }

  /// 27 pixels button
  dp27(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 15.3
        : screenHeight(context) / 15.3;
  }

  /// 28 pixels button
  dp28(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 14.8
        : screenHeight(context) / 14.8;
  }

  /// 29 pixels button
  dp29(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 14.3
        : screenHeight(context) / 14.3;
  }

  /// 30 pixels button
  dp30(BuildContext context) {
    return _orientation(context) == Orientation.portrait
        ? screenWidth(context) / 13.8
        : screenHeight(context) / 13.8;
  }

  /// 31 pixels button
  dp34(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 10
      : screenHeight(context) / 11;

  /// 32 pixels button
  dp38(BuildContext context) => _orientation(context) == Orientation.portrait
      ? screenWidth(context) / 10
      : screenHeight(context) / 10;

  Orientation _orientation(BuildContext context) => MediaQuery.of(context).orientation;
}