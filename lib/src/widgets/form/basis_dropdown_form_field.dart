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
    this.lightLabel = false,
    this.labelChild,
    this.radius,
    this.borderColor,
    this.fillColor,
    this.bold = false,
    this.boldLabel = false,
    this.showBorder = true,
  });

  final List<String> items;
  final ValueChanged<String?> onChanged;
  final FormFieldSetter<String?>? onSaved;
  final String? value, fieldLabel;
  final Color? color, disabledColor, labelColor, borderColor, fillColor;
  final FocusNode? focusNode;
  final double? fontSize, width, height, verticalPadding, labelSize, radius;
  final GlobalKey<FormState>? formKey;
  final bool enabled, 
             lightLabel, 
             showBorder,
             boldLabel,
             bold;
  final Widget? labelChild;

  @override
  State<BasisDropdownFormField> createState() => _BasisDropdownFormFieldState();
}

class _BasisDropdownFormFieldState extends State<BasisDropdownFormField> with BasisFormFieldStyle {

  late double _labelSize;

  @override
  void didChangeDependencies() {
    _labelSize = widget.labelSize ?? 16.dp;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OdxInputBorder(
      showBorder: widget.showBorder,
      focused: widget.focusNode?.hasFocus ?? false,
      borderColor: widget.borderColor,
      radius: widget.radius,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 4.dp),
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
                  light: widget.lightLabel,
                  bold: widget.boldLabel,
                ),

                if (widget.labelChild != null)...[
                  SizedBox(width: 10.dp),

                  widget.labelChild!,
                ],
              ],
            ),

            SizedBox(height: 8.dp),
          ],

          SizedBox(
            width: widget.width ?? 36.w,
            height: widget.height,
            child: ButtonTheme(
              alignedDropdown: true,
              child: Form(
                key: widget.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: DropdownButtonFormField(
                  focusNode: widget.focusNode,
                  value: widget.value,
                  style: getInputStyle(context, bold: widget.bold, fontSize: widget.fontSize),
                  menuMaxHeight: 200.dp,
                  onSaved: widget.onSaved,
                  validator: widget.formKey != null ? (value) {
                    if (value == null) return 'Campo obrigatório';

                    return null;
                  } : null,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 12.dp),
                    hintStyle: getInputHintStyle(context, fontSize: widget.fontSize),
                    filled: true,
                    fillColor: getFillColor(
                      context,
                      fillColor: widget.fillColor,
                      enabled: widget.enabled, 
                      disabledColor: widget.disabledColor,
                    ),
                    contentPadding: widget.height != null
                      ? const EdgeInsets.symmetric()
                      : EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 10.dp),
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
                        constraints: BoxConstraints(maxWidth: 6.w),
                        child: BasisText(
                          value,
                          light: true,
                          fontSize: widget.fontSize ?? 16.dp,
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