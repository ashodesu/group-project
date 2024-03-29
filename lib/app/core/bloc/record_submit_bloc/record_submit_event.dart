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

class GetInitData extends RecordSubmitEvent {}

class SubmitData extends RecordSubmitEvent {
  final Record data;

  SubmitData(this.data);
}

class ExportCSV extends RecordSubmitEvent {
  final Record data;
  final String path;

  ExportCSV(this.data, this.path);
}

class ImportCSV extends RecordSubmitEvent {
  final FilePickerResult result;

  ImportCSV(this.result);
}
