import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisButton extends StatelessWidget with ResponsiveSizes {
  final Function()? onPressed;
  final String title;
  final double? btnHeight, width, fontSize, horizontalPadding, radius;
  final bool fullWidth;
  final bool loading;
  final bool bold;
  final Color? disabledColor;
  final Color? backgroundColor, color;
  
  const BasisButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.btnHeight,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: btnHeight ?? (isTablet(context) ? sBtn(context) : btn(context)),
      width: fullWidth ? screenWidth(context) : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding != null
              ? horizontalPadding!
              : dp20(context),
          ),
          disabledBackgroundColor: disabledColor ?? Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? dp4(context))),
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: loading
          ? BasisLoading(color: color ?? Colors.white, size: dp12(context))
          : BasisText(
              title, 
              color: color ?? Colors.white, 
              fontSize: fontSize ?? dp16(context),
              bold: bold,
            ),
      ),
    );
  }
}
