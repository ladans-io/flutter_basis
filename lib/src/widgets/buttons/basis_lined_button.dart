
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';
import 'package:flutter_basis/src/responsive/basis_responsive_sizer.dart';

class BasisLinedButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double? height, width, fontSize, horizontalPadding, radius;
  final bool fullWidth;
  final bool loading, disabled, bold;
  final Color? color, borderColor, foregroundColor;
  final TextStyle? textStyle;

  const BasisLinedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.height,
    this.fontSize,
    this.width,
    this.fullWidth = true,
    this.loading = false,
    this.disabled = false,
    this.bold = false,
    this.color,
    this.borderColor,
    this.foregroundColor,
    this.horizontalPadding,
    this.radius,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.secondary;
    final textColor = disabled ? Colors.grey : color ?? onPrimary;

    return SizedBox(
      height: height ?? (isTablet(context) ? 40 : 50),
      width: fullWidth ? dw(context) : width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding != null
              ? horizontalPadding!
              : 20,
          ),
          disabledBackgroundColor: Colors.transparent,
          surfaceTintColor: color ?? onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 4)),
          side: BorderSide(color: (disabled ? Colors.grey.shade500 : borderColor ?? color) ?? onPrimary),
          shadowColor: Colors.transparent,
          foregroundColor: foregroundColor ?? onPrimary,
        ),
        onPressed: onPressed,
        child: loading
          ? BasisLoading(color: color ?? onPrimary, size: 10)
          : Text(title, style: textStyle ?? TextStyle(color: textColor, fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: fontSize ?? 16)),
      ),
    );
  }
}
