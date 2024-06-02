import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BasisText extends StatefulWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final bool bold;
  final bool extraBold;
  final bool semiBold;
  final bool light;
  final bool alignCenter;
  final bool justify;
  final String? fontFamily;
  final bool overflowVisible;
  final bool overflowEllipsis;
  final bool overflowFade;
  final bool overflowClip;
  final bool italic;
  final bool underline;
  final bool web;
  final EdgeInsetsGeometry? padding;

  const BasisText(
    this.text, {
      super.key,
      this.color,
      this.fontSize,
      this.light = false,
      this.bold = false,
      this.extraBold = false,
      this.semiBold = false,
      this.alignCenter = false,
      this.justify = false,
      this.fontFamily,
      this.overflowClip = false,
      this.overflowEllipsis = false,
      this.overflowFade = false,
      this.overflowVisible = false,
      this.italic = false,
      this.underline = false,
      this.web = false,
      this.padding,
    }
  );

  @override
  State<BasisText> createState() => _OdxTextState();
}

class _OdxTextState extends State<BasisText> {
  FontWeight? get _fontWeight {
    if (widget.light) {
      return FontWeight.w400;
    } else if (widget.bold) {
      return FontWeight.w700;
    } else if (widget.extraBold) {
      return FontWeight.w800;
    } else if (widget.semiBold) {
      return FontWeight.w600;
    } else {
      return FontWeight.w500;
    }
  }

  TextStyle get _style {
    return TextStyle(
      color: widget.color ?? Colors.black87,
      fontSize: widget.fontSize ?? 14,
      fontWeight: _fontWeight,
      fontFamily: widget.fontFamily,
      fontStyle: widget.italic ? FontStyle.italic : FontStyle.normal,
      decoration: widget.underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: widget.color,
    );
  }

  Widget shadow(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          Positioned(
            top: 2.0,
            left: 2.0,
            child: Text(
              widget.text,
              style: _style.copyWith(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
              ),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Text(
              widget.text,
              key: widget.key,
              textAlign: _textAlignment,
              style: _style,
            ),
          ),
        ],
      ),
    );
  }

  TextAlign get _textAlignment {
    if (widget.alignCenter) {
      return TextAlign.center;
    } else if (widget.justify) {
      return TextAlign.justify;
    } else {
      return TextAlign.start;
    }
  }

  TextOverflow? get _overflow {
    if (widget.overflowClip) {
      return TextOverflow.clip;
    } else if (widget.overflowVisible) {
      return TextOverflow.visible;
    } else if (widget.overflowEllipsis) {
      return TextOverflow.ellipsis;
    } else if (widget.overflowFade) {
      return TextOverflow.fade;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: widget.web 
        ? SelectableText(
            widget.text,
            textAlign: _textAlignment,
            style: _style,
          ) 
        : Text(
            widget.text,
            textAlign: _textAlignment,
            overflow: _overflow,
            style: _style,
          ),
    );
  }
}
