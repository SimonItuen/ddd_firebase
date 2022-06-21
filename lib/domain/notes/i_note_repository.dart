import 'package:dartz/dartz.dart';
import 'package:ddd_firebase/domain/notes/note.dart';
import 'package:ddd_firebase/domain/notes/note_failure.dart';
import 'package:kt_dart/kt.dart';

abstract class INoteRepository{
  //watch notes
  //Watch uncompleted notes
  //CUD

  //in this case we'll use streams to watch notes

  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);

}