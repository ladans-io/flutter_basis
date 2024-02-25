import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../flutter_basis.dart';
import '../colors.dart';

Timer? _timer;

var closed = false;

void showBasisBanner(
    String msg, {
    bool error = false,
    bool info = false,
    Duration? duration,
    String? prefixIcon,
    Color? backgroundColor,
    Color? fontColor,
    String? fontFamily,
    double? fontSize,
    double? radius,
}) {
  closed = false;
    showDialog(
        context: Navigate.navigatorKey.currentState!.overlay!.context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (_) {
            return GestureDetector(
              onVerticalDragStart: (_) => closeBanner(),
              onVerticalDragEnd: (_) => closeBanner(),
              child: BannerContent(
                  message: msg,
                  prefixIcon: prefixIcon,
                  backgroundColor: backgroundColor,
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  fontColor: fontColor,
                  radius: radius,
                  state: error
                      ? BannerState.error
                      : info
                          ? BannerState.info
                          : BannerState.success,
              ),
            );
        },
    );

    _timer = Timer(
        duration ?? const Duration(seconds: 3),
        closeBanner,
    );
}

void closeBanner() {
  if (!closed) {
    _timer?.cancel();
    _timer = null;

    Navigate.to.pop();

    closed = true;
  }
}

class BannerContent extends StatelessWidget with ResponsiveSizes {
    const BannerContent({
        super.key,
        required this.message,
        required this.state,
        this.prefixIcon,
        this.backgroundColor,
        this.fontColor,
        this.fontFamily,
        this.fontSize,
        this.radius,
    });

    final String message;
    final String? prefixIcon, fontFamily;
    final BannerState state;
    final Color? backgroundColor, fontColor;
    final double? fontSize, radius;

    @override
    Widget build(BuildContext context) {
        final borderRadius = BorderRadius.circular(radius ?? dp25(context));

        return Column(
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: (backgroundColor ?? snackBarColor).withOpacity(.6),
                    borderRadius: borderRadius,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: dp10(context)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: dp16(context),
                        horizontal: dp20(context),
                    ),
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
                                    fontFamily: fontFamily,
                                    fontSize: fontSize,
                                ),
                            ),

                            SizedBox(width: dp10(context)),

                            Icon(
                                switch (state) {
                                    BannerState.success => Icons.check_circle,
                                    BannerState.info => Icons.info_rounded,
                                    BannerState.error => Icons.error_rounded,
                                },
                                color: switch (state) {
                                    BannerState.success => successColor,
                                    BannerState.info => infoColor,
                                    BannerState.error => errorColor,
                                },
                                size: dp28(context),
                            ),
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
    }
}

enum BannerState { error, info, success }