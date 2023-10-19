import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class FLoadingCard extends StatelessWidget with ResponsiveSizes {
  final bool onWillPop;
  final String? loadingPlaceholder;
  final Color? color;
  final VoidCallback? onCancel;

  const FLoadingCard({
    Key? key, 
    this.onWillPop = false, 
    this.loadingPlaceholder,
    this.color,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        WillPopScope(
          onWillPop: () async => onWillPop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRespValue(context, 8, 2)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dp20(context) * 2),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FLoading(color: color ?? Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(height: dp10(context)),
                        if (loadingPlaceholder != null) FText(
                          loadingPlaceholder!,
                          fontSize: dp16(context),
                          alignCenter: true,
                          bold: true,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (onCancel != null) Positioned(
          bottom: dp25(context) * 2,
          child: FloatingActionButton(
            tooltip: 'Cancelar requisição',
            elevation: 1,
            backgroundColor: Colors.red,
            onPressed: onCancel ?? Navigate.to.pop,
            child: const Icon(Icons.close, color: Colors.white),
          ),
        ),
      ],
    );
  }

  static show({
    String? loadingPlaceholder, 
    Color? color, 
    VoidCallback? onCancel,
  }) {
    showDialog(
      barrierDismissible: false,
      context: Navigate.navigatorKey.currentState!.overlay!.context, 
      barrierColor: Colors.transparent,
      builder: (context) => FLoadingCard(
        loadingPlaceholder: loadingPlaceholder, 
        color: color,
        onCancel: onCancel,
      ),
    );
  }
}
