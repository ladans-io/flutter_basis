import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

import '../colors.dart';

void showBasisAlert(
    String msg, {
      bool error = false,
      bool info = false,
      Duration? duration,
      String? prefixIcon,
      Color? backgroundColor,
      BorderRadiusGeometry? radius,
    }) => BasisAlert.show(
    message: msg,
    prefixIcon: prefixIcon,
    radius: radius ?? BorderRadius.zero,
    backgroundColor: (backgroundColor ?? snackBarColor).withOpacity(.9),
    duration: duration ?? const Duration(seconds: 4),
    state: error
      ? AlertState.error
      : info
        ? AlertState.info
        : AlertState.success,
);

void closeAlert() {
  GlobalKeys.scaffoldMessengerKey.currentState?.clearSnackBars();
}

class BasisAlert {
  static show({
    required String message,
    required AlertState state,
    String? prefixIcon,
    Color? backgroundColor,
    EdgeInsetsGeometry? margin, padding,
    AlertBehavior? behavior,
    BorderRadiusGeometry? radius,
    Duration duration = const Duration(seconds: 3),
    DismissDirection? dismissDirection,
  }) {
    return GlobalKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: backgroundColor ?? snackBarColor,
        dismissDirection: dismissDirection ?? DismissDirection.down,
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: radius ?? BorderRadius.circular(4)),
        padding: padding,
        margin: behavior?.value == 1
          ? margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          : null,
        content: AlertContent(
          message: message,
          state: state,
          prefixIcon: prefixIcon, 
          backgroundColor: backgroundColor,
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
  });

  final String message;
  final String? prefixIcon;
  final AlertState state;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            color: Colors.white,
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

