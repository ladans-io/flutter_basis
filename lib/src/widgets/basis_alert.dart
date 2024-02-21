import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

const Color _snackBarBgColor = Color(0xFF303030);
const Color _successColor = Color(0xFF4CAF50);
const Color _errorColor = Color(0xFFFF5252);
final Color _infoColor = Colors.amber.shade800;

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
        backgroundColor: backgroundColor ?? _snackBarBgColor,
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
        Icon(
          switch (state) {
            AlertState.success => Icons.check_circle,
            AlertState.info => Icons.info_rounded,
            AlertState.error => Icons.error_rounded,
          },
          color: switch (state) {
            AlertState.success => _successColor,
            AlertState.info => _infoColor,
            AlertState.error => _errorColor,
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

