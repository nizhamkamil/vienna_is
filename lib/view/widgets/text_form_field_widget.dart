// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.showLabel,
      this.enabled,
      this.textCtrl,
      this.textInputFormatter,
      this.textInputType,
      this.validator,
      this.maxLength,
      this.maxLines,
      this.customValidator,
      this.readOnly,
      required this.obscureText,
      this.type,
      this.prefixIcon})
      : super(key: key);

  String labelText;
  String? hintText;
  bool? showLabel;
  bool? enabled;
  TextEditingController? textCtrl;
  TextInputType? textInputType;
  List<TextInputFormatter>? textInputFormatter;
  bool? validator = false;
  String? Function(String?)? customValidator;
  int? maxLength;
  int? maxLines;
  bool? readOnly = false;
  bool obscureText = false;
  Icon? prefixIcon;
  String? type;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  Icon? suffixIcon;

  VoidCallback? onSuffixIconTap;

  RxBool isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: true,
      child: TextFormField(
        // enabled: enabled ?? true,
        // readOnly: enabled ?? true,
        obscureText: widget.obscureText,
        enableInteractiveSelection: widget.enabled ?? true,
        onTap: widget.enabled == false
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : () {},
        minLines: 1,
        maxLines: widget.maxLines ?? 5,
        maxLength: widget.maxLength,
        keyboardType: widget.textInputType,
        inputFormatters: widget.textInputFormatter,
        decoration: InputDecoration(
          labelText: widget.showLabel == false ? null : widget.labelText.tr,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.type == 'password'
              ? IconButton(
                  onPressed: () {
                    isVisible.value = !isVisible.value;
                    widget.obscureText = !widget.obscureText;
                    setState(() {});
                  },
                  icon: isVisible.value
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off))
              : null,
          hintText: widget.hintText ?? widget.labelText.tr,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(10.0),
          fillColor: Colors.grey[300],
          filled: widget.enabled == false ? true : false,
          // counterText: '',
        ),
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom * 1.5),
        controller: widget.textCtrl,
        validator: widget.validator == true
            ? (value) {
                if (value != null && value.isEmpty) {
                  return 'fieldCannot'.tr;
                } else if (value != null && value.trim().isEmpty) {
                  return 'whitespaceWarning'.tr;
                }
                return null;
              }
            : widget.customValidator,
        readOnly: widget.readOnly ?? false,
      ),
    );
  }
}
