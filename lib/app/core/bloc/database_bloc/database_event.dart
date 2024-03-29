part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object> get props => [];
}

class GetData extends DatabaseEvent {
  final int page;

  const GetData({required this.page});
}

class ToDetails extends DatabaseEvent {
  final DatabaseObject data;
  final ScrollController scrollController;
  final double scrollOffset;
  final String birdType;

  ToDetails(this.data, this.scrollController, this.scrollOffset, this.birdType);
}

class GoDB extends DatabaseEvent {}

class SearchDatabase extends DatabaseEvent {
  final String keywords;
  final bool searching;

  SearchDatabase(this.keywords, this.searching);
}
