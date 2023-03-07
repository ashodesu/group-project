import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Function()? onPressed;
  final double height;
  final double width;
  final Widget child;
  final Color? color;

  const SquareButton(
      {super.key,
      required this.onPressed,
      required this.height,
      required this.width,
      required this.child,
      this.color});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color ?? grey),
        minimumSize: MaterialStateProperty.all(
          Size(width, height),
        ),
      ),
      child: child,
    );
  }
}
