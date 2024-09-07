import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../flutter_basis.dart';

var updateOdxTextFieldValue = true;

class BasisFormField extends StatefulWidget {
  final String? fieldLabel;
  final String? hintText;
  final bool obscureText,
             validate,
             showSuffixIcon,
             showBorderOnFocus,
             showBorder,
             statusEnabled,
             enabled,
             lightLabel,
             boldLabel,
             bold,
             focuseBorder,
             showValidationStatus;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final double? labelSize, radius, fontSize, focusedBorderWidth;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Color? labelColor, disabledColor, borderColor, fillColor, color, successColor;
  final EdgeInsetsGeometry? contentPadding, errorPadding;
  final TextAlign? textAlign;
  final Widget? labelChild;
  final String? suffixText;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final GlobalKey<FormState>? formKey;

  const BasisFormField({
    Key? key,
    this.fieldLabel,
    this.statusEnabled = true,
    required this.controller,
    this.onChanged,
    this.onSubmit,
    this.enabled = true,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.labelSize,
    this.validate = true,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onSaved,
    this.labelColor,
    this.disabledColor,
    this.lightLabel = false,
    this.boldLabel = false,
    this.contentPadding,
    this.errorPadding,
    this.showBorder = true,
    this.focuseBorder = true,
    this.showBorderOnFocus = false,
    this.showValidationStatus = false,
    this.textAlign,
    this.labelChild,
    this.suffixText,
    this.textCapitalization,
    this.formKey,
    this.suffixIcon,
    this.showSuffixIcon = true,
    this.obscureText = false,
    this.borderColor,
    this.radius,
    this.fillColor,
    this.bold = false,
    this.fontSize,
    this.color,
    this.successColor,
    this.focusedBorderWidth,
  }) : super(key: key);

  @override
  State<BasisFormField> createState() => _BasisFormFieldState();
}

class _BasisFormFieldState extends State<BasisFormField> with BasisFormFieldStyle {

  late bool _obscureText;
  var _success = false;

  late double _labelSize;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _labelSize = widget.labelSize ?? 16;
    super.didChangeDependencies();
  }

  IconData get _visibilityIcon {
    return _obscureText 
      ? Icons.visibility_outlined 
      : Icons.visibility_off_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final grey400 = Colors.grey.shade400;

    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldLabel != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BasisText(
                  widget.fieldLabel!,
                  fontSize: _labelSize,
                  color: widget.labelColor,
                  bold: widget.boldLabel,
                  light: widget.lightLabel,
                ),

                if (widget.labelChild != null)...[
                  SizedBox(width: 10),

                  widget.labelChild!,
                ],
              ],
            ),

            SizedBox(height: 8),
          ],

          FormField<String>(
            onSaved: widget.onSaved,
            validator: widget.enabled && widget.formKey != null
              ? widget.validator
              : null,
            builder: (state) {
              final inputBorder = OdxInputBorder(
                success: _success,
                error: state.hasError,
                showBorder: widget.showBorder,
                showBorderOnFocus: widget.showBorderOnFocus,
                focused: widget.focusNode?.hasFocus ?? false,
                statusEnabled: widget.statusEnabled,
                borderColor: widget.borderColor,
                radius: widget.radius,
                successColor: widget.successColor,
                focusedBorderWidth: widget.focusedBorderWidth,
              );

              if (widget.controller.text.isNotEmpty && updateOdxTextFieldValue) {
                Future(() {
                  state.didChange(widget.controller.text);
                  if (!state.hasError) setState(() => _success = true);
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    focusNode: widget.focusNode,
                    enabled: widget.enabled,
                    style: getInputStyle(
                      context,
                      bold: widget.bold,
                      fontSize: widget.fontSize,
                      color: widget.color,
                    ),
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    keyboardType: widget.keyboardType,
                    textInputAction: Platform.isIOS && widget.textInputAction == TextInputAction.none
                      ? TextInputAction.done
                      : widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
                    controller: widget.controller,
                    obscureText: _obscureText,
                    cursorColor: primaryColor,
                    onChanged: (value) {
                      if (widget.onChanged != null) widget.onChanged!(value);
                      state.didChange(value);
                    },
                    onSubmitted: widget.onSubmit,
                    textAlign: widget.textAlign ?? TextAlign.left,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: widget.hintText,
                      hintStyle: getInputHintStyle(context),
                      errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 12),
                      filled: true,
                      fillColor: getFillColor(
                        context,
                        fillColor: widget.fillColor,
                        enabled: widget.enabled, 
                        disabledColor: widget.disabledColor,
                      ),
                      border: inputBorder.get(),
                      focusedBorder: inputBorder.copy(focusedBorder: widget.focuseBorder).get(),
                      enabledBorder: inputBorder.get(),
                      disabledBorder: inputBorder.get(),
                      contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      suffix: widget.suffixText != null ? Text(widget.suffixText!) : null,
                      suffixStyle: getInputHintStyle(context),
                      suffixIcon: widget.showSuffixIcon ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statusTile(
                              context,
                              success: _success,
                              error: state.hasError,
                              focused: widget.focusNode?.hasFocus ?? false,
                              showValidationStatus: widget.showValidationStatus,
                              successColor: widget.successColor,
                            ),
                            if (widget.obscureText || widget.suffixIcon != null) SizedBox(width: 12),
                            if (widget.obscureText) ...[
                              GestureDetector(
                                child: Icon(_visibilityIcon, size: 24, color: grey400),
                                onTap: () => setState(() => _obscureText = !_obscureText)
                              ),
                              SizedBox(width: 12),
                            ],
                            widget.suffixIcon ?? const SizedBox.shrink(),
                          ],
                        ),
                      ) : null,
                    ),
                  ),

                  if (state.hasError)...[
                    SizedBox(height: 4),

                    Padding(
                      padding: widget.errorPadding ?? EdgeInsets.zero,
                      child: BasisText(state.errorText!, color: Colors.red.shade300, light: true),
                    ),
                  ],
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}

