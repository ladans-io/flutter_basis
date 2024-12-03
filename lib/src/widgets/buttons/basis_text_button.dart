
import 'package:flutter/material.dart';
import 'package:flutter_basis/src/responsive/basis_responsive_sizer.dart';

class BasisTextButton extends StatelessWidget {
  const BasisTextButton({
    super.key, 
    required this.title, 
    this.onPressed,
    this.color,
    this.fontSize,
    this.height,
    this.width,
    this.radius,
    this.fullWidth = false,
    this.underline = false,
    this.paddingZero = false,
    this.bold = false,
    this.textStyle,
  });

  final String title;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color? color;
  final double? fontSize, height, width, radius;
  final bool fullWidth, underline, paddingZero, bold;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: fullWidth ? dw(context) : width,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
          ),
          padding: paddingZero ? EdgeInsets.zero : null,
        ),
        onPressed: onPressed, 
        child: Text(
          title, 
          style: textStyle ?? TextStyle(
            color: color ?? Colors.black54, 
            fontWeight: bold ? FontWeight.bold : FontWeight.normal, 
            fontSize: fontSize ?? 16,
            decoration: underline ? TextDecoration.underline : TextDecoration.none
          ),
        ),
      ),
    );
  }
}