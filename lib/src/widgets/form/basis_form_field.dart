import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'basis_form_field_style.dart';

import '../../../flutter_basis.dart';

var updateOdxTextFieldValue = true;

class BasisFormField extends StatefulWidget {
  final String? fieldLabel;
  final String? password;
  final String? hintText;
  final bool isPassword,
             isEmail,
             isConfirmPassword,
             isCpfCnpj,
             validate,
             showSuffixIcon,
             showBorderOnFocus,
             showBorder,
             statusEnabled,
             enabled,
             labelLightWeight;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final double? labelSize;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Color? labelColor, disabledColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final Widget? labelChild;
  final String? suffixText;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final GlobalKey<FormState>? formKey;

  const BasisFormField({
    Key? key,
    this.fieldLabel,
    this.isPassword = false,
    this.isEmail = false,
    this.isConfirmPassword = false,
    this.isCpfCnpj = false,
    this.statusEnabled = true,
    required this.controller,
    this.onChanged,
    this.onSubmit,
    this.password,
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
    this.labelLightWeight = false,
    this.contentPadding,
    this.showBorder = true,
    this.showBorderOnFocus = false,
    this.textAlign,
    this.labelChild,
    this.suffixText,
    this.textCapitalization,
    this.formKey,
    this.suffixIcon,
    this.showSuffixIcon = true,
  }) : super(key: key);

  @override
  State<BasisFormField> createState() => _BasisFormFieldState();
}

class _BasisFormFieldState extends State<BasisFormField> with ResponsiveSizes,
                                                                  BasisFormFieldStyle {

  var _obscureText = true;
  var _success = false;


  late double _labelSize;

  @override
  void didChangeDependencies() {
    _labelSize = widget.labelSize ?? dp16(context);
    super.didChangeDependencies();
  }

  IconData get _visibilityIcon {
    return _obscureText 
      ? Icons.visibility_outlined 
      : Icons.visibility_off_outlined;
  }

  bool get _isPasswordField {
    return widget.isPassword || widget.isConfirmPassword;
  }

  bool get _hasSuffix {
    return _isPasswordField || widget.suffixIcon != null;
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
                  light: widget.labelLightWeight,
                ),

                if (widget.labelChild != null)...[
                  SizedBox(width: dp10(context)),

                  widget.labelChild!,
                ],
              ],
            ),

            SizedBox(height: dp8(context)),
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
                    style: getInputStyle(context),
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    keyboardType: widget.keyboardType,
                    textInputAction: Platform.isIOS && widget.textInputAction == TextInputAction.none
                      ? TextInputAction.done
                      : widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
                    controller: widget.controller,
                    obscureText: _obscureText && (widget.isPassword || widget.isConfirmPassword),
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
                      errorStyle: TextStyle(color: Colors.red.shade300, fontSize: dp12(context)),
                      filled: true,
                      fillColor: getFillColor(context, enabled: widget.enabled, disabledColor: widget.disabledColor),
                      border: inputBorder.get(),
                      focusedBorder: inputBorder.copy(focusedBorder: true).get(),
                      enabledBorder: inputBorder.get(),
                      disabledBorder: inputBorder.get(),
                      contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: dp16(context), vertical: dp10(context)),
                      suffix: widget.suffixText != null ? Text(widget.suffixText!) : null,
                      suffixStyle: getInputHintStyle(context),
                      suffixIcon: widget.showSuffixIcon ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: dp14(context)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _isPasswordField
                              ? GestureDetector(
                                  child: Icon(_visibilityIcon, size: dp30(context), color: grey400),
                                  onTap: () => setState(() => _obscureText = !_obscureText)
                                )
                              : widget.suffixIcon ?? const SizedBox.shrink(),

                            if (_hasSuffix) SizedBox(width: dp14(context)),

                            statusTile(
                              context,
                              error: state.hasError,
                              success: _success,
                              focused: widget.focusNode?.hasFocus ?? false,
                            ),
                          ],
                        ),
                      ) : null,
                    ),
                  ),

                  if (state.hasError)...[
                    SizedBox(height: dp4(context)),

                    BasisText(state.errorText!, color: Colors.red.shade300, light: true),
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

