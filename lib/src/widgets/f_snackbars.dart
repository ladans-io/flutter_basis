import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

import 'f_text.dart';

const Color _snackBarBgColor = Color(0xFF303030);
const Color _successColor = Color(0xFF4CAF50);
const Color _errorColor = Color(0xFFFF5252);
final Color _infoColor = Colors.amber.shade800;

Color _getColor(ESnackBarState state) =>
  switch (state) {
    ESnackBarState.success => _successColor,
    ESnackBarState.info => _infoColor,
    ESnackBarState.error => _errorColor,
  };

IconData _getIcon(ESnackBarState state) =>
  switch (state) {
    ESnackBarState.success => Icons.check_circle,
    ESnackBarState.info => Icons.info_rounded,
    ESnackBarState.error => Icons.error_rounded,
  };

class FSnackBars {
  static show({
    required String message,
    required ESnackBarState state,
  }) {
    return GlobalKeys.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        content: FSnackBarContent(message: message, state: state),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class FSnackBarContent extends StatelessWidget with ResponsiveSizes {
  const FSnackBarContent({
    super.key, 
    required this.message, 
    required this.state,
    this.suffixIcon,
  }) : assert(
    suffixIcon is String, 
    'The icon to be displayed as your suffix brand identity',
  );

  final String message;
  final String? suffixIcon;
  final ESnackBarState state;

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
            if (suffixIcon != null) ...[
              Container(
                width: dp22(context),
                height: dp22(context),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(suffixIcon!)),
                ),
              ),
              SizedBox(width: dp10(context)),
            ],
            Expanded(
              child: FText(
                message,
                color: Colors.white,
                light: true,
                overflowFade: true,
              ),
            ),
            Icon(
              _getIcon(state),
              color: _getColor(state),
              size: dp28(context),
            ),
          ],
        ),
      ),
    );
  }
}

enum ESnackBarState { error, info, success }

