import 'package:flutter/material.dart';

mixin BasisFormFieldStyle {
  TextStyle getInputStyle(
    BuildContext context, {
      double? fontSize,
      bool bold = false,
        Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color ?? Colors.black87,
    );
  }

  TextStyle getInputHintStyle(BuildContext context, {double? fontSize}) {
    return TextStyle(
      color: Colors.grey,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w400,
    );
  }

  Color getFillColor(
    BuildContext context, {
      bool enabled = true,
      Color? disabledColor,
      Color? fillColor,
    }
  ) {
    return enabled
      ? fillColor ?? Theme.of(context).cardColor
      : (disabledColor ?? Theme.of(context).colorScheme.primary.withOpacity(.03));
  }

  Widget statusTile(
      BuildContext context, {
      required bool error,
      required bool success,
      required bool focused,
      Color? successColor,
  }) {
    if (error) {
      return Icon(
        Icons.error, 
        size: 20, 
        color: Colors.red.shade400,
      );
    } 

    if (success && focused) {
      return Icon(
        Icons.check_circle, 
        size: 20, 
        color: successColor ?? Colors.green,
      );
    } 

    return const SizedBox.shrink();
  }
}

class OdxInputBorder extends OutlineInputBorder {
  const OdxInputBorder({
    this.error = false,
    this.success = false,
    this.showBorderOnFocus = false,
    this.showBorder = false,
    this.focusedBorder = false,
    this.focused = false,
    this.statusEnabled = true,
    this.borderColor,
    this.successColor,
    this.radius,
    this.focusedBorderWidth,
  });

  final Color? borderColor, successColor;
  final double? radius;
  final double? focusedBorderWidth;
  final bool error,
             success,
             showBorderOnFocus,
             showBorder,
             focusedBorder,
             statusEnabled,
             focused;

  OdxInputBorder copy({
    bool? focusedBorder,
    bool? focused,
    bool? success,
    bool? error,
    Color? successColor,
  }) {
    return OdxInputBorder(
      error: error ?? this.error,
      success: success ?? this.success,
      showBorderOnFocus: showBorderOnFocus,
      showBorder: showBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      successColor: successColor ?? this.successColor,
      focused: focused ?? this.focused,
      statusEnabled: statusEnabled,
    );
  }

  InputBorder get _border {
    Color getColor() {
      if (success && !error && focused && statusEnabled) {
        return successColor ?? Colors.green;
      } 
      if (error) return Colors.red.shade400;
      if ((showBorderOnFocus && focused) || showBorder) {
        return borderColor ?? const Color(0xFFE6E6E6);
      }
      return Colors.transparent;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 5),
      borderSide: focusedBorder 
        ? BorderSide(width: (focusedBorderWidth ?? 1.5), color: getColor()) 
        : BorderSide.none,
    );
  }

  InputBorder get() => _border;
}