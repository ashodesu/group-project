part of 'record_submit_bloc.dart';

abstract class RecordSubmitEvent extends Equatable {
  const RecordSubmitEvent();

  @override
  List<Object> get props => [];
}

class NextStep extends RecordSubmitEvent {
  final Record record;

  NextStep({required this.record});
}

class PreviousStep extends RecordSubmitEvent {
  final Record record;

  PreviousStep({required this.record});
}
