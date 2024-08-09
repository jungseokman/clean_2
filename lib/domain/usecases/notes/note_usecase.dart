import 'package:flutter_note_app/domain/usecases/notes/create_note.dart';
import 'package:flutter_note_app/domain/usecases/notes/delete_note.dart';
import 'package:flutter_note_app/domain/usecases/notes/get_note.dart';
import 'package:flutter_note_app/domain/usecases/notes/get_notes.dart';
import 'package:flutter_note_app/domain/usecases/notes/update_note.dart';

class NoteUsecase {
  final GetNote getNote;
  final CreateNote createNote;
  final DeleteNote deleteNote;
  final UpdateNote updateNote;
  final GetNotes getNotes;
  NoteUsecase({
    required this.getNote,
    required this.createNote,
    required this.deleteNote,
    required this.updateNote,
    required this.getNotes,
  });
}
