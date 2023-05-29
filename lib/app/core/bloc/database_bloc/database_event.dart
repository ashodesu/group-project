part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class GetData extends DatabaseEvent {
  final int page;
  final int pageSize;

  const GetData({required this.page, required this.pageSize});
}

class ToDetails extends DatabaseEvent {
  final DatabaseObject data;
  final ScrollController scrollController;
  final double scrollOffset;

  ToDetails(this.data, this.scrollController, this.scrollOffset);
}

class GoDB extends DatabaseEvent {}

class SearchDatabase extends DatabaseEvent {
  final String keywords;
  final bool searching;

  SearchDatabase(this.keywords, this.searching);
}
