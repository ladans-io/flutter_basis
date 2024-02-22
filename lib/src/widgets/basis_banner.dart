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
}) {
  closed = false;
    showDialog(
        barrierDismissible: false,
        context: Navigate.navigatorKey.currentState!.overlay!.context,
        builder: (_) {
            return GestureDetector(
              onVerticalDragStart: (_) => closeBanner(),
              onVerticalDragEnd: (_) => closeBanner(),
              child: BannerContent(
                  message: msg,
                  prefixIcon: prefixIcon,
                  backgroundColor: backgroundColor,
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
    });

    final String message;
    final String? prefixIcon;
    final BannerState state;
    final Color? backgroundColor;

    @override
    Widget build(BuildContext context) {
        return Column(
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(
                  color: (backgroundColor ?? snackBarColor).withOpacity(.5),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.all(dp20(context)),
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