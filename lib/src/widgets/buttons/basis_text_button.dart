
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisTextButton extends StatelessWidget {
  const BasisTextButton({
    super.key, 
    required this.title, 
    this.onPressed,
    this.color,
    this.fontSize,
    this.btnHeight,
    this.btnWidth,
    this.fullWidth = false,
    this.underline = false,
    this.paddingZero = false,
    this.bold = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? color;
  final double? fontSize, btnHeight, btnWidth;
  final bool fullWidth, underline, paddingZero, bold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: btnHeight ?? 50.dp,
      width: fullWidth ? Device.width : btnWidth,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.dp),
          ),
          padding: paddingZero ? EdgeInsets.zero : null,
        ),
        onPressed: onPressed, 
        child: BasisText(
          title,
          color: color ?? Colors.black54,
          fontSize: fontSize ?? 16.dp,
          underline: underline,
          bold: bold,
        ),
      ),
    );
  }
}