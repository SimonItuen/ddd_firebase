import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:ddd_firebase/domain/notes/i_note_repository.dart';
import 'package:ddd_firebase/domain/notes/note.dart';
import 'package:ddd_firebase/domain/notes/note_failure.dart';
import 'package:ddd_firebase/domain/notes/value_objects.dart';
import 'package:ddd_firebase/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

part 'note_form_bloc.freezed.dart';
part 'note_form_event.dart';
part 'note_form_state.dart';

@Injectable()
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _noteRepository;
  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial()) {
    on<Initialized>((event, emit) async{
      emit(event.initialNoteOption.fold(() => state, (initialNote) => state.copyWith(note: initialNote, isEditing: true)));
    });
    on<BodyChanged>((event, emit) async{
      emit(state.copyWith(note: state.note.copyWith(body: NoteBody(event.bodyStr)),saveFailureOrSuccessOption: none()));
    });
    on<ColorChanged>((event, emit) async{
      emit(state.copyWith(note: state.note.copyWith(color: NoteColor(event.color)),saveFailureOrSuccessOption: none()));
    });
    on<TodosChanged>((event, emit) async{
      emit(state.copyWith(note: state.note.copyWith(todos: List3(event.todos.map((primitive) => primitive.toDomain()))),saveFailureOrSuccessOption: none()));
    });
    on<Saved>((event, emit) async{
      Option<Either<NoteFailure, Unit>> failureOrSuccessOption = none();
      emit(state.copyWith(isSaving: true, saveFailureOrSuccessOption: none()));
      if(state.note.failureOption.isNone()){
         failureOrSuccessOption = optionOf(state.isEditing? await _noteRepository.update(state.note):await _noteRepository.create(state.note));
      }
      emit(state.copyWith(isSaving: false,showErrorMessages: true, saveFailureOrSuccessOption:  failureOrSuccessOption));
    });


  }
}
