import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: black, width: 0.4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (title == 'Home') ...[
                const SizedBox(width: 50),
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                ),
                IconButton(
                  onPressed: () {
                    context.push('/home/submit');
                  },
                  icon: Image.asset('assets/images/icon_add.png'),
                )
              ] else if (title == 'Database') ...[
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                ),
              ] else if (title == 'User') ...[
                const SizedBox(width: 50),
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/icon_setting.png'),
                )
              ] else ...[
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                ),
                const SizedBox(width: 50),
              ],
            ],
          ),
          const SizedBox(height: 8),
          if (title == 'Database') ...[
            SizedBox(
              width: screenWidth * 0.14,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search_rounded),
                  labelText: "Search",
                ),
                style: TextStyle(fontSize: 20),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  print("Submitted");
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
