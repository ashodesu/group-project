part of 'record_submit_bloc.dart';

abstract class RecordSubmitState extends Equatable {
  const RecordSubmitState();

  @override
  List<Object> get props => [];
}

class RecordSubmitInitial extends RecordSubmitState {}

class StepChanged extends RecordSubmitState {
  final Record record;

  @override
  List<Object> get props => [record.step];

  const StepChanged({required this.record});
}

class StepChangeError extends RecordSubmitState {}
