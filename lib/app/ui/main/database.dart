import 'package:asm/app/core/bloc/database_bloc/database_bloc.dart';
import 'package:asm/app/core/obj/database.dart';
import 'package:asm/app/ui/components/button_square.dart';
import 'package:asm/app/ui/components/database_card.dart';
import 'package:asm/app/ui/components/top_bar_app.dart';
import 'package:asm/app/ui/sub/database_details/details.dart';
import 'package:asm/config.dart';
import 'package:asm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Database extends StatelessWidget {
  final DatabaseBloc bloc = DatabaseBloc();
  final ScrollController scrollController = ScrollController();
  List<DatabaseObject> dataList = [];
  DatabaseConfig config = DatabaseConfig();
  DatabaseObject data = DatabaseObject();
  int page = 1;
  bool searching = false;

  Database({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: 'Database',
            databaseBloc: bloc,
          ),
          Expanded(
            child: BlocConsumer<DatabaseBloc, DatabaseState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is ShowDetails) {
                  data = state.data;
                }
                if (state is GetDataSuccess) {
                  page = state.page;
                  searching = false;
                }
                if (state is SearchSuccess) {
                  searching = state.searching;
                }
              },
              builder: (context, state) {
                if (state is GetDataSuccess ||
                    state is ShowDatabase ||
                    state is GetDataFailed ||
                    state is SearchSuccess ||
                    state is SearchFailed) {
                  if (state is GetDataSuccess) {
                    dataList = state.dataList;
                  }
                  if (state is SearchSuccess) {
                    dataList = state.dataList;
                  }
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        if (dataList.length != 0) ...[
                          for (var i = 0; i < dataList.length; i++) ...[
                            DatabaseCard(
                              data: dataList[i],
                              bloc: bloc,
                              controller: scrollController,
                            ),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (page != 1 && state is GetDataSuccess ||
                                  (state is ShowDatabase && !searching)) ...[
                                SquareButton(
                                  onPressed: () {
                                    scrollController.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                    bloc.add(GetData(
                                        page: page - 1,
                                        pageSize: config.pageSize));
                                  },
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.07,
                                  child: Text(
                                    'Previous',
                                    style: TextStyle(fontFamily: fontStyle),
                                  ),
                                ),
                              ],
                              if ((state is GetDataSuccess ||
                                      (state is ShowDatabase && !searching)) &&
                                  dataList.length == config.pageSize) ...[
                                SquareButton(
                                  onPressed: () {
                                    scrollController.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                    bloc.add(GetData(
                                        page: page + 1,
                                        pageSize: config.pageSize));
                                  },
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.07,
                                  child: Text(
                                    'Next',
                                    style: TextStyle(fontFamily: fontStyle),
                                  ),
                                ),
                              ],
                              if (state is SearchSuccess ||
                                  (state is ShowDatabase && searching)) ...[
                                SquareButton(
                                  onPressed: () {
                                    scrollController.animateTo(0,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                    searching = false;
                                    bloc.add(GetData(
                                        page: page, pageSize: config.pageSize));
                                  },
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.07,
                                  child: Text(
                                    'Back',
                                    style: TextStyle(fontFamily: fontStyle),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ] else ...[
                          if (state is GetDataSuccess ||
                              state is ShowDatabase) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No Data In This Page',
                                  style: TextStyle(
                                      fontFamily: fontStyle, fontSize: 36),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (page != 1) ...[
                                  SquareButton(
                                    onPressed: () {
                                      bloc.add(GetData(
                                          page: page - 1,
                                          pageSize: config.pageSize));
                                    },
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.07,
                                    child: Text(
                                      'Previous',
                                      style: TextStyle(fontFamily: fontStyle),
                                    ),
                                  ),
                                ] else ...[
                                  SquareButton(
                                    onPressed: () {
                                      bloc.add(GetData(
                                          page: page,
                                          pageSize: config.pageSize));
                                    },
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.07,
                                    child: Text(
                                      'Refresh',
                                      style: TextStyle(fontFamily: fontStyle),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                          if (state is GetDataFailed) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Data Failed, please try to Refresh or Contect The Admin',
                                  style: TextStyle(
                                      fontFamily: fontStyle, fontSize: 36),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SquareButton(
                                  onPressed: () {
                                    bloc.add(GetData(
                                        page: page, pageSize: config.pageSize));
                                  },
                                  height: screenHeight * 0.04,
                                  width: screenWidth * 0.07,
                                  child: Text(
                                    'Refresh',
                                    style: TextStyle(fontFamily: fontStyle),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (state is SearchSuccess ||
                              state is SearchFailed) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state is SearchSuccess
                                      ? 'No Data'
                                      : 'Search Failed, please try to Refresh or Contect The Admin',
                                  style: TextStyle(
                                      fontFamily: fontStyle, fontSize: 36),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (state is SearchSuccess ||
                                    state is ShowDatabase) ...[
                                  SquareButton(
                                    onPressed: () {
                                      bloc.add(GetData(
                                          page: page,
                                          pageSize: config.pageSize));
                                    },
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.07,
                                    child: Text(
                                      'Back',
                                      style: TextStyle(fontFamily: fontStyle),
                                    ),
                                  ),
                                ] else ...[
                                  SquareButton(
                                    onPressed: () {
                                      bloc.add(GetData(
                                          page: page,
                                          pageSize: config.pageSize));
                                    },
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.07,
                                    child: Text(
                                      'Refresh',
                                      style: TextStyle(fontFamily: fontStyle),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ]
                        ],
                      ],
                    ),
                  );
                }
                if (state is ShowDetails) {
                  if (data.id != null) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: DatabaseDetails(
                        bloc: bloc,
                        data: data,
                        scrollController: state.scrollController,
                        scrollOffset: state.scrollOffset,
                      ),
                    );
                  }
                }
                if (dataList.length == 0) {
                  bloc.add(GetData(page: page, pageSize: config.pageSize));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
