import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

mixin BasisFormFieldStyle on ResponsiveSizes {
  TextStyle getInputStyle(BuildContext context, {double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? dp16(context),
      color: Colors.black87,
    );
  }

  TextStyle getInputHintStyle(BuildContext context, {double? fontSize}) {
    return TextStyle(
      color: Colors.grey,
      fontSize: fontSize ?? dp16(context),
      fontWeight: FontWeight.w400,
    );
  }

  Color getFillColor(
    BuildContext context, {
      bool enabled = true,
      Color? disabledColor,
    }
  ) {
    return enabled
      ? Theme.of(context).cardColor
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
        size: dp20(context), 
        color: Colors.red.shade400,
      );
    } 

    if (success && focused) {
      return Icon(
        Icons.check_circle, 
        size: dp20(context), 
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
  });

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
      if ((showBorderOnFocus && focused) || showBorder) return const Color(0xFFE6E6E6);

      return Colors.transparent;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: focusedBorder ? 2.5 : 1,
        color: getColor(),
      ),
    );
  }

  InputBorder get() => _border;
}