import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';
import 'package:flutter_basis/src/utils/play_audio.dart';

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
      Color? backgroundColor,
      double? radius,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      Color? fontColor,
      bool playSound = false,
      String? errorAudioPath,
      String? successAudioPath,
    }
) {
  void emitAlert() => BasisAlert.show(
    message: msg,
    prefixIcon: prefixIcon,
    radius: radius,
    backgroundColor: (backgroundColor ?? snackBarColor).withOpacity(.9),
    duration: duration ?? const Duration(seconds: 4),
    margin: margin,
    fontColor: fontColor,
    padding: padding,
    state: _getState(error, info),
  );

  if (playSound) {
    if (errorAudioPath == null && successAudioPath == null) {
      throw('You need to specify the errorAudioPath & successAudioPath');
    } else {
      playAudio(error ? errorAudioPath! : successAudioPath!).then((value) => null);
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
    Color? backgroundColor,
    Color? fontColor,
    EdgeInsetsGeometry? margin, padding,
    AlertBehavior? behavior,
    double? radius,
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
          fontColor: fontColor,
          backgroundColor: backgroundColor,
          radius: radius,
        ),
        behavior: behavior?.getBehavior(),
      ),
    );
  }
}

class AlertContent extends StatelessWidget with ResponsiveSizes {
  const AlertContent({
    super.key, 
    required this.message, 
    required this.state,
    this.prefixIcon,
    this.backgroundColor,
    this.fontColor,
    this.radius,
  });

  final String message;
  final String? prefixIcon;
  final AlertState state;
  final Color? backgroundColor, fontColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius ?? .0);

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: screenWidth(context),
          decoration: BoxDecoration(
            color: (backgroundColor ?? snackBarColor).withOpacity(.8),
            borderRadius: borderRadius,
          ),
          padding: EdgeInsets.all(dp16(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                Container(
                  width: dp22(context),
                  height: dp22(context),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(prefixIcon!)),
                  ),
                ),

                SizedBox(width: dp10(context)),
              ],

              Expanded(
                child: BasisText(
                  message,
                  color: fontColor ?? Colors.white,
                  light: true,
                  overflowFade: true,
                ),
              ),

              SizedBox(width: dp10(context)),

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
                size: dp28(context),
              ),
            ],
          ),
        ),
      ),
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

