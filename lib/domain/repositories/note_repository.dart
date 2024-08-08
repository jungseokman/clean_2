import 'package:flutter_note_app/domain/models/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();
  Future<Note?> getNoteById(int id);
  Future<void> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(Note note);
}
