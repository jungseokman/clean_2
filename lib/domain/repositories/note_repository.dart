import 'package:flutter_note_app/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();
  Future<Note> getNoteById();
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(Note note);
}
