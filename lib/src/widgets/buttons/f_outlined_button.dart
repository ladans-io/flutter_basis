
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class FOutlinedButton extends StatelessWidget with ResponsiveSizes {
  final Function()? onPressed;
  final String title;
  final double? btnHeight, width, fontSize, horizontalPadding, radius;
  final bool fullWidth;
  final bool loading, disabled, bold;
  final Color? color, borderColor, foregroundColor;
  const FOutlinedButton({
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
      height: btnHeight ?? (isTablet(context) ? sBtn(context) : btn(context)),
      width: fullWidth ? screenWidth(context) : width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding != null
              ? horizontalPadding!
              : dp20(context),
          ),
          disabledBackgroundColor: Colors.transparent,
          surfaceTintColor: color ?? onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? dp4(context)),
          ),
          side: BorderSide(color: (disabled ? Colors.grey.shade500 : borderColor ?? color) ?? onPrimary),
          shadowColor: Colors.transparent,
          foregroundColor: foregroundColor ?? onPrimary,
        ),
        onPressed: onPressed,
        child: loading
          ? FLoading(color: color ?? onPrimary, size: dp10(context))
          : FText(
              title, 
              color: textColor, 
              fontSize: fontSize ?? dp16(context),
              bold: bold,
            ),
      ),
    );
  }
}
