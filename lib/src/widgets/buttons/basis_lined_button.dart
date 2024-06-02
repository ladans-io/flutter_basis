
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisLinedButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double? btnHeight, width, fontSize, horizontalPadding, radius;
  final bool fullWidth;
  final bool loading, disabled, bold;
  final Color? color, borderColor, foregroundColor;
  const BasisLinedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.btnHeight,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.secondary;
    final textColor = disabled ? Colors.grey : color ?? onPrimary;

    return SizedBox(
      height: btnHeight ?? (Device.screenType == ScreenType.tablet ? 40.dp : 50.dp),
      width: fullWidth ? Device.width : width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding != null
              ? horizontalPadding!
              : 20.dp,
          ),
          disabledBackgroundColor: Colors.transparent,
          surfaceTintColor: color ?? onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 4.dp),
          ),
          side: BorderSide(color: (disabled ? Colors.grey.shade500 : borderColor ?? color) ?? onPrimary),
          shadowColor: Colors.transparent,
          foregroundColor: foregroundColor ?? onPrimary,
        ),
        onPressed: onPressed,
        child: loading
          ? BasisLoading(color: color ?? onPrimary, size: 10.dp)
          : BasisText(
              title, 
              color: textColor, 
              fontSize: fontSize ?? 16.dp,
              bold: bold,
            ),
      ),
    );
  }
}
