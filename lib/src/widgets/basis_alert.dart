import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';
import 'package:flutter_basis/src/responsive/basis_responsive_sizer.dart';

import '../colors.dart';

AlertState _getState(bool error, bool info) {
  if (error) return AlertState.error;
  if (info) return AlertState.info;

  return AlertState.success;
}

void showBasisAlert(
    String msg, {
      bool error = false,
      bool info = false,
      Duration? duration,
      String? prefixIcon,
      Widget? prefix,
      Widget? suffix,
      Color? backgroundColor,
      double? radius,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      Color? fontColor,
      bool playSound = false,
      String? errorPath,
      String? path,
    }
) {
  void emitAlert() => BasisAlert.show(
    message: msg,
    prefixIcon: prefixIcon,
    prefix: prefix,
    suffix: suffix,
    radius: radius,
    backgroundColor: backgroundColor ?? snackBarColor,
    duration: duration ?? const Duration(seconds: 4),
    margin: margin,
    fontColor: fontColor,
    padding: padding,
    state: _getState(error, info),
  );
  
  if (playSound) {
    if (path != null) {
      playAlert(
        errorPath: error ? errorPath : null,
        error: error,
        path: path,
      );
    } else {
      throw Exception('Path shouldn\'t be null');
    }
  }

  emitAlert();
}

void closeAlert() => GlobalKeys.scaffoldMessengerKey.currentState?.clearSnackBars();

class BasisAlert {
  static show({
    required String message,
    required AlertState state,
    String? prefixIcon,
    Widget? prefix,
    Widget? suffix,
    Color? backgroundColor,
    Color? fontColor,
    EdgeInsetsGeometry? margin, padding,
    AlertBehavior? behavior,
    double? radius,
    double? fontSize,
    Duration duration = const Duration(seconds: 3),
  }) {
    return GlobalKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: duration,
        padding: padding ?? EdgeInsets.zero,
        margin: behavior?.value == 1 ? margin : null,
        content: AlertContent(
          message: message,
          state: state,
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffix: suffix,
          fontColor: fontColor,
          backgroundColor: backgroundColor,
          radius: radius,
          fontSize: fontSize,
        ),
        behavior: behavior?.getBehavior(),
      ),
    );
  }
}

class AlertContent extends StatelessWidget {
  const AlertContent({
    super.key, 
    required this.message, 
    required this.state,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.fontColor,
    this.radius,
    this.fontSize,
  });

  final String message;
  final String? prefixIcon;
  final Widget? prefix, suffix;
  final AlertState state;
  final Color? backgroundColor, fontColor;
  final double? radius, fontSize;

  Widget _buildContent(BuildContext context) {
    return Container(
      width: dw(context),
      decoration: BoxDecoration(
        color: backgroundColor ?? snackBarColor,
        borderRadius: BorderRadius.circular(radius ?? .0),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixIcon != null || prefix != null) ...[
            if (prefixIcon != null) 
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(prefixIcon!))),
              ) 
            else
              prefix!,
            SizedBox(width: 10),
          ],

          Expanded(
            child: BasisText(
              message,
              color: fontColor ?? Colors.white,
              light: true,
              overflowFade: true,
              fontSize: fontSize,
            ),
          ),
          if (prefix == null) ...[            
            SizedBox(width: 10),
            Icon(
              switch (state) {
                AlertState.success => Icons.check_circle,
                AlertState.info => Icons.info_rounded,
                AlertState.error => Icons.error_rounded,
              },
              color: switch (state) {
                AlertState.success => successColor,
                AlertState.info => infoColor,
                AlertState.error => errorColor,
              },
              size: 28,
            ),
          ],
          if (suffix != null) ...[            
            SizedBox(width: 10),
            suffix!
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? .0),
      child: Platform.isIOS ? BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: _buildContent(context),
      ) : _buildContent(context),
    );
  }
}

enum AlertState { error, info, success }

enum AlertBehavior {
  floating(1),
  fixed(2);

  const AlertBehavior(this.value);
  final int value;

  SnackBarBehavior getBehavior() {
    if (value == 1) {
      return SnackBarBehavior.floating;
    } else {
      return SnackBarBehavior.fixed;
    }
  }
}

