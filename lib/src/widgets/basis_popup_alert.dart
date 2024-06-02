import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisPopupAlert extends StatefulWidget {
  final String title;
  final String confirmLabel;
  final String? cancelLabel;
  final String? description, confirmButtonTitle;
  final VoidCallback? onPressed;
  final bool cancelable;
  final bool redTitle;
  final Widget? child;
  final bool loading;

  const BasisPopupAlert({
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
  State<BasisPopupAlert> createState() => _BasisPopupAlertState();
}

class _BasisPopupAlertState extends State<BasisPopupAlert> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: AlertDialog.adaptive(
          actionsAlignment: MainAxisAlignment.center,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.dp)),
          surfaceTintColor: Colors.transparent,
          title: _title,
          content: widget.description != null ? _description : null,
          actions: [
            if (widget.cancelable) _onCancelButton,
            if (widget.loading) BasisLoading(color: Colors.white, size: 12.dp)
            else _onConfirmButton,
          ],
        ),
      ),
    );
  }

  Widget get _title {
    return BasisText(
      widget.title,
      alignCenter: true,
      fontSize: 16.dp,
      bold: widget.description != null,
      color: widget.redTitle ? Colors.red : Colors.black87,
    );
  }

  Widget get _description {
    return widget.child != null
      ? widget.child!
      : BasisText(widget.description!, color: Colors.black87);
  }

  Widget get _onConfirmButton {
    return BasisButton(
      radius: Platform.isIOS ? 0 : null,
      horizontalPadding: 44.dp,
      backgroundColor: Colors.red,
      onPressed: widget.onPressed,
      fullWidth: false,
      title: widget.confirmLabel,
    );
  }

  Widget get _onCancelButton {
    return BasisLinedButton(
      borderColor: Platform.isIOS ? Colors.transparent : null,
      radius: Platform.isIOS ? 0 : null,
      horizontalPadding: 44.dp,
      onPressed: Navigator.of(context).pop,
      fullWidth: false,
      title: widget.cancelLabel ?? 'Cancelar',
    );
  }
}
