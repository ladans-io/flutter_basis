import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

const Color _snackBarBgColor = Color(0xFF303030);
const Color _successColor = Color(0xFF4CAF50);
const Color _errorColor = Color(0xFFFF5252);
final Color _infoColor = Colors.amber.shade800;

class BasisAlert {
  static show({
    required String message,
    required AlertState state,
    String? prefixIcon,
  }) {
    return GlobalKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        content: AlertContent(message: message, state: state, prefixIcon: prefixIcon),
        behavior: SnackBarBehavior.floating,
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
  });

  final String message;
  final String? prefixIcon;
  final AlertState state;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(dp20(context)),
      child: Container(
        width: screenWidth(context),
        padding: EdgeInsets.all(dp15(context)),
        constraints: BoxConstraints(
          maxHeight: screenHeight(context) * .5,
        ),
        color: _snackBarBgColor,
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
        ),
      ),
    );
  }
}

enum AlertState { error, info, success }

