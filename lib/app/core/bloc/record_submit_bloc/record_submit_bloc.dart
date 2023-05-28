import 'dart:io';
import 'package:asm/app/core/obj/record.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'record_submit_event.dart';
part 'record_submit_state.dart';

class RecordSubmitBloc extends Bloc<RecordSubmitEvent, RecordSubmitState> {
  RecordSubmitBloc() : super(RecordSubmitInitial()) {
    on<NextStep>((event, emit) {
      Record record = event.record;
      if (record.step < 3) {
        record.step += 1;
        emit(StepChanged(record: record));
      }
      emit(StepChangeError());
    });
    on<PreviousStep>(
      (event, emit) {
        Record record = event.record;
        if (record.step > 1) {
          record.step -= 1;
          emit(StepChanged(record: record));
        }
        emit(StepChangeError());
      },
    );
    on<AddPhoto>(
      (event, emit) {
        emit(PhotoUpdate(record: event.record));
        emit(PhotoUpdated());
      },
    );
  }
}
