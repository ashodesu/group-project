import 'package:asm/app/core/bloc/database_bloc/database_bloc.dart';
import 'package:asm/app/core/service/storage_service.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatelessWidget {
  TopBar({super.key, required this.title, this.databaseBloc});

  final String title;
  final DatabaseBloc? databaseBloc;
  final StorageService storageService = StorageService();

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
                  onPressed: () async {
                    String? token = await storageService.getToken();
                    if (token != null) {
                      context.push('/home/submit');
                    } else {
                      context.pop();
                    }
                  },
                  icon: Image.asset('assets/images/icon_add.png'),
                )
              ] else if (title == 'Database') ...[
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                ),
              ] else if (title == 'User') ...[
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontFamily: fontStyle),
                ),
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
                  if (value != null) {
                    databaseBloc!.add(SearchDatabase(value, true));
                  }
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
