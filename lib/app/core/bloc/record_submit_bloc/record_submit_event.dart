part of 'record_submit_bloc.dart';

abstract class RecordSubmitEvent extends Equatable {
  const RecordSubmitEvent();

  @override
  List<Object> get props => [];
}

class NextStep extends RecordSubmitEvent {
  final Record record;

  const NextStep({required this.record});
}

class PreviousStep extends RecordSubmitEvent {
  final Record record;

  const PreviousStep({required this.record});
}

class AddPhoto extends RecordSubmitEvent {
  final Record record;

  const AddPhoto({required this.record});
}
