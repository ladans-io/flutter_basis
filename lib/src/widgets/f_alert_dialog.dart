import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class FAlertDialog extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final String? cancelLabel;
  final String? description, confirmButtonTitle;
  final VoidCallback? onPressed;
  final bool cancelable;
  final bool redTitle;
  final Widget? child;
  final bool loading;

  const FAlertDialog({
    Key? key,
    required this.title,
    this.description,
    this.onPressed,
    this.confirmButtonTitle,
    this.cancelable = false,
    this.redTitle = false,
    this.loading = false,
    this.child,
    required this.confirmLabel,
    this.cancelLabel,
  }) : super(key: key);

  @override
  State<FAlertDialog> createState() => _FAlertDialogState();
}

class _FAlertDialogState extends State<FAlertDialog> with ResponsiveSizes {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: AlertDialog.adaptive(
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(dp6(context))),
          surfaceTintColor: Colors.transparent,
          title: _title,
          content: widget.description != null ? _description : null,
          actions: [
            if (widget.cancelable) _onCancelButton,
            if (widget.loading) FLoading(color: Colors.white, size: dp12(context))
            else _onConfirmButton,
          ],
        ),
      ),
    );
  }

  Widget get _title {
    return FText(
      widget.title,
      alignCenter: true,
      fontSize: dp16(context),
      bold: widget.description != null,
      color: widget.redTitle ? Colors.red : Colors.black87,
    );
  }

  Widget get _description {
    return widget.child != null
      ? widget.child!
      : FText(widget.description!, color: Colors.black87);
  }

  Widget get _onConfirmButton {
    return FElevatedButton(
      radius: Platform.isIOS ? 0 : null,
      horizontalPadding: dp22(context) * 2,
      backgroundColor: Colors.red,
      onPressed: widget.onPressed,
      fullWidth: false,
      title: widget.confirmLabel,
    );
  }

  Widget get _onCancelButton {
    return FOutlinedButton(
      borderColor: Platform.isIOS ? Colors.transparent : null,
      radius: Platform.isIOS ? 0 : null,
      horizontalPadding: dp22(context) * 2,
      onPressed: Navigator.of(context).pop,
      fullWidth: false,
      title: widget.cancelLabel ?? 'Cancelar',
    );
  }
}
