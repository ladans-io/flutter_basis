import 'package:flutter/material.dart';
import 'package:flutter_basis/flutter_basis.dart';

class BasisDropdownFormField extends StatefulWidget {
  const BasisDropdownFormField({
    super.key, 
    required this.items, 
    required this.onChanged,
    this.onSaved,
    this.width,
    this.height,
    this.verticalPadding,
    this.value,
    this.color,
    this.disabledColor,
    this.enabled = true,
    this.focusNode,
    this.fontSize,
    this.formKey,
    this.fieldLabel,
    this.labelSize,
    this.labelColor,
    this.labelLightWeight = false,
    this.labelChild,
    this.radius,
  });

  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldSetter<String?>? onSaved;
  final String? value, fieldLabel;
  final Color? color, disabledColor, labelColor;
  final FocusNode? focusNode;
  final double? fontSize, width, height, verticalPadding, labelSize, radius;
  final GlobalKey<FormState>? formKey;
  final bool enabled, labelLightWeight;
  final Widget? labelChild;

  @override
  State<BasisDropdownFormField> createState() => _BasisDropdownFormFieldState();
}

class _BasisDropdownFormFieldState extends State<BasisDropdownFormField> with ResponsiveSizes,
                                                                              BasisFormFieldStyle {

  late double _labelSize;

  @override
  void didChangeDependencies() {
    _labelSize = widget.labelSize ?? dp16(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = OdxInputBorder(showBorder: true);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? dp4(context)),
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

          SizedBox(
            width: widget.width ?? screenWidth(context) * .36,
            height: widget.height,
            child: ButtonTheme(
              alignedDropdown: true,
              child: Form(
                key: widget.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: DropdownButtonFormField(
                  focusNode: widget.focusNode,
                  value: widget.value,
                  style: getInputStyle(context, fontSize: widget.fontSize),
                  menuMaxHeight: dp25(context) * 8,
                  onSaved: widget.onSaved,
                  validator: widget.formKey != null ? (value) {
                    if (value == null) return 'Campo obrigatório';

                    return null;
                  } : null,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red.shade300, fontSize: dp12(context)),
                    hintStyle: getInputHintStyle(context, fontSize: widget.fontSize),
                    filled: true,
                    fillColor: getFillColor(context, enabled: widget.enabled, disabledColor: widget.disabledColor),
                    contentPadding: widget.height != null
                      ? const EdgeInsets.symmetric()
                      : EdgeInsets.symmetric(vertical: widget.verticalPadding ?? dp10(context)),
                    border: inputBorder.get(),
                    focusedBorder: inputBorder.copy(focusedBorder: true).get(),
                    enabledBorder: inputBorder.get(),
                    errorBorder: inputBorder.copy(error: true).get(),
                    focusedErrorBorder: inputBorder.copy(focusedBorder: true, error: true).get(),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: widget.enabled ? widget.onChanged : null,
                  items: widget.items.map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: screenWidth(context) * .6),
                        child: BasisText(
                          value,
                          light: true,
                          fontSize: widget.fontSize ?? dp16(context),
                          color: widget.enabled ? widget.color : Colors.black87,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}