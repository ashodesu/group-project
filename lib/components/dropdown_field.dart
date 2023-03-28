import 'dart:math';

import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  DropDownField({
    super.key,
    this.label,
    this.hint,
    required this.items,
    this.onChanged,
    this.validator,
  });

  final String? label;
  final String? hint;
  final List<String> items;
  final Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          textBaseline: TextBaseline.alphabetic,
          color: grey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        hintText: hint,
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
      ),
    );
  }
}
