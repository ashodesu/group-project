part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class GetDataSuccess extends DatabaseState {
  final int page;
  final List<DatabaseObject> dataList;

  @override
  List<Object> get props => [page, dataList];
  const GetDataSuccess({required this.page, required this.dataList});
}

class GetDataFailed extends DatabaseState {}

class ShowDetails extends DatabaseState {
  final DatabaseObject data;
  final ScrollController scrollController;
  final double scrollOffset;

  ShowDetails(this.data, this.scrollController, this.scrollOffset);
}

class ShowDatabase extends DatabaseState {}

class SearchSuccess extends DatabaseState {
  final List<DatabaseObject> dataList;
  final bool searching;

  @override
  List<Object> get props => [dataList];
  SearchSuccess(this.dataList, this.searching);
}

class SearchFailed extends DatabaseState {}
