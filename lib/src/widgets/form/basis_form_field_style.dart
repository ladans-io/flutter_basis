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
        color: Colors.green,
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
    this.radius,
  });

  final Color? borderColor;
  final double? radius;
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
  }) {
    return OdxInputBorder(
      error: error ?? this.error,
      success: success ?? this.success,
      showBorderOnFocus: showBorderOnFocus,
      showBorder: showBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      focused: focused ?? this.focused,
      statusEnabled: statusEnabled,
    );
  }

  InputBorder get _border {
    Color getColor() {
      if (success && !error && focused && statusEnabled) return Colors.green;
      if (error) return Colors.red.shade400;
      if ((showBorderOnFocus && focused) || showBorder) return borderColor ?? const Color(0xFFE6E6E6);

      return Colors.transparent;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 5),
      borderSide: BorderSide(
        width: focusedBorder ? 2.5 : 1,
        color: getColor(),
      ),
    );
  }

  InputBorder get() => _border;
}