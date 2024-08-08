import 'package:flutter_note_app/data/datasources/note_db.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDb db;
  NoteRepositoryImpl({
    required this.db,
  });

  @override
  Future<void> createNote(Note note) async {
    await db.createNote(note);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await db.deleteNote(note);
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await db.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await db.getNotes();
  }

  @override
  Future<void> updateNote(Note note) async {
    await db.updateNote(note);
  }
}
