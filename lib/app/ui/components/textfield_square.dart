import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class TextFieldSquare extends StatelessWidget {
  final Function(String? val)? onChanged;
  final Function(String?)? onSaved;
  final String? labelText;
  final String? hintText;
  final String? Function(Object?)? validate;
  final bool? hideText;
  final bool? readOnly;
  final TextEditingController? controller;
  final Function()? onTap;
  final String? prefixText;
  final Widget? suffixIcon;
  final String? initialValue;
  final int? maxLength;
  final int? maxLine;
  final TextAlign? textAlign;

  const TextFieldSquare({
    super.key,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.hintText,
    this.validate,
    this.hideText,
    this.readOnly,
    this.controller,
    this.onTap,
    this.prefixText,
    this.suffixIcon,
    this.initialValue,
    this.maxLength,
    this.maxLine,
    this.textAlign,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      textAlign: textAlign ?? TextAlign.center,
      obscureText: hideText ?? false,
      validator: validate,
      readOnly: readOnly ?? false,
      onTap: onTap,
      maxLength: maxLength,
      maxLines: maxLine,

      //Text Style
      style: const TextStyle(fontSize: 20),

      //Field Style
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          textBaseline: TextBaseline.alphabetic,
          color: grey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20),
        filled: true,
        fillColor: white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: grey,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: grey,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: red,
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: red,
            width: 2,
          ),
        ),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        prefixText: prefixText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
