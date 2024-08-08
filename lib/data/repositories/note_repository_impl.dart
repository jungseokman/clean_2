import 'package:flutter_note_app/data/datasources/note_db.dart';
import 'package:flutter_note_app/domain/entities/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDb db;
  NoteRepositoryImpl({
    required this.db,
  });

  @override
  Future<void> createNote(Note note) {
    // TODO: implement createNote
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNote(Note note) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Note> getNoteById() {
    // TODO: implement getNoteById
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getNotes() {
    // TODO: implement getNotes
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
