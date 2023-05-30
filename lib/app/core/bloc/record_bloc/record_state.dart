part of 'record_bloc.dart';

abstract class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

class RecordInitial extends RecordState {}

class GetRecordSuccess extends RecordState {
  final List<Record> dataList;
  final int page;
  @override
  List<Object> get props => [dataList];
  GetRecordSuccess(this.dataList, this.page);
}

class GetRecordFailed extends RecordState {
  final String msg;
  @override
  List<Object> get props => [msg];
  GetRecordFailed(this.msg);
}
