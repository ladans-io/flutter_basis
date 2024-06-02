import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisRichText extends StatelessWidget {
  const BasisRichText({
    super.key,
    this.bold = false,
    this.bold1 = false,
    this.bold2 = false,
    this.extraBold = false,
    this.extraBold1 = false,
    this.extraBold2 = false,
    this.semiBold = false,
    this.semiBold1 = false,
    this.semiBold2 = false,
    this.fontFamily1,
    this.fontFamily2,
    this.light = false,
    this.light1 = false,
    this.light2 = false,
    required this.text1,
    required this.text2,
    this.color,
    this.color1,
    this.color2,
    this.fontSize,
    this.fontSize1,
    this.fontSize2,
    this.fontFamily,
    this.textAlign,
    this.onTap1,
    this.onTap2,
  });
  final bool bold, bold1, bold2,
      light, light1, light2,
      semiBold, semiBold1, semiBold2,
      extraBold, extraBold1, extraBold2;
  final String text1, text2;
  final String? fontFamily, fontFamily1, fontFamily2;
  final Color? color, color1, color2;
  final double? fontSize, fontSize1, fontSize2;
  final TextAlign? textAlign;
  final VoidCallback? onTap1, onTap2;

  FontWeight? get _fontWeight1 {
    if (light || light1) {
      return FontWeight.w400;
    } else if (bold || bold1) {
      return FontWeight.w700;
    } else if (extraBold || extraBold1) {
      return FontWeight.w800;
    } else if (semiBold | semiBold1) {
      return FontWeight.w600;
    } else {
      return FontWeight.w500;
    }
  }

  FontWeight? get _fontWeight2 {
    if (light || light2) {
      return FontWeight.w400;
    } else if (bold || bold2) {
      return FontWeight.w700;
    } else if (extraBold || extraBold1) {
      return FontWeight.w800;
    } else if (semiBold || semiBold1) {
      return FontWeight.w600;
    } else {
      return FontWeight.w500;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text1,
            recognizer: TapGestureRecognizer()..onTap = onTap2,
            style: TextStyle(
              color: color ?? color1 ?? primaryColor,
              fontSize: fontSize ?? fontSize1 ?? 14.dp,
              fontWeight: _fontWeight1,
              fontFamily: fontFamily1 ?? fontFamily,
            ),
          ),
          TextSpan(
            text: text2,
            recognizer: TapGestureRecognizer()..onTap = onTap2,
            style: TextStyle(
              color: color ?? color2 ?? primaryColor,
              fontSize: fontSize ?? fontSize2 ?? 14.dp,
              fontWeight: _fontWeight2,
              fontFamily: fontFamily2 ?? fontFamily,
            ),
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}