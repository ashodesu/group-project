import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class TextFieldRadiusToSquare extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? labelText;
  final String? hintText;
  final String? Function(Object?)? validate;
  final bool? hideText;
  final bool? autocorrect;
  final TextEditingController? controller;

  const TextFieldRadiusToSquare({
    super.key,
    this.onChanged,
    required this.onSaved,
    this.labelText,
    this.hintText,
    this.validate,
    this.hideText,
    this.autocorrect,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onSaved: onSaved,
      textAlign: TextAlign.center,
      obscureText: hideText ?? false,
      validator: validate,
      controller: controller,

      //Text Style
      style: const TextStyle(fontSize: 20),

      //Field Style
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          textBaseline: TextBaseline.alphabetic,
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 20),
        filled: true,
        fillColor: white,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: black,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: black,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
      ),
      autocorrect: autocorrect ?? true,
    );
  }
}
