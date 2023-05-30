part of 'record_bloc.dart';

abstract class RecordEvent extends Equatable {
  const RecordEvent();

  @override
  List<Object> get props => [];
}

class GetRecord extends RecordEvent {
  final int page;

  GetRecord(this.page);
}
