import 'package:asm/theme.dart';
import 'package:flutter/material.dart';

class DBTextLine extends StatelessWidget {
  final List<String?> text;

  const DBTextLine({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (text[0] == "Name:" || text[0] == "SciName:") ...[
          Row(
            children: [
              for (int i = 0; i < text.length; i++) ...[
                if (i == 0) ...[
                  Text(
                    text[i] ?? "None",
                    style: TextStyle(fontSize: 24, fontFamily: fontStyle),
                  ),
                ] else ...[
                  Flexible(
                    child: Text(
                      text[i] ?? "None",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
                if (i != text.length - 1) ...[
                  SizedBox(width: screenWidth * 0.0085),
                ],
              ],
            ],
          )
        ] else ...[
          if (text[0] != "Name:" || text[0] != "SciName:") ...[
            for (int i = 0; i < text.length; i++) ...[
              if (i == 0) ...[
                Row(
                  children: [
                    Text(
                      text[i] ?? "None",
                      style: TextStyle(fontSize: 24, fontFamily: fontStyle),
                    ),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        text[i] ?? "None",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ],
        SizedBox(height: screenWidth * 0.0085),
      ],
    );
  }
}
