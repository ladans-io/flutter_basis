import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';
import 'package:flutter_basis/src/responsive/basis_responsive_sizer.dart';

class BasisButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final TextStyle? textStyle;
  final double? height, width, fontSize, horizontalPadding, radius;
  final bool fullWidth;
  final bool loading;
  final bool bold;
  final Color? disabledColor;
  final Color? backgroundColor, color;
  
  const BasisButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.height,
    this.fontSize,
    this.width,
    this.radius,
    this.fullWidth = true,
    this.loading = false,
    this.bold = false,
    this.disabledColor,
    this.backgroundColor,
    this.color,
    this.horizontalPadding,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height ?? (isTablet(context) ? 40 : 50),
      width: fullWidth ? dw(context) : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding != null
              ? horizontalPadding!
              : 20,
          ),
          disabledBackgroundColor: disabledColor ?? Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 4)),
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          textStyle: textStyle,
        ),
        onPressed: onPressed,
        child: loading
          ? BasisLoading(color: color ?? Colors.white, size: 12)
          : Text(
              title, 
              style: textStyle ?? TextStyle(
                color: color ?? Colors.white, 
                fontWeight: bold ? FontWeight.bold : FontWeight.normal, 
                fontSize: fontSize ?? 16,
              )
            ),
      ),
    );
  }
}
