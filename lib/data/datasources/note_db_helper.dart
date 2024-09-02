import 'package:flutter_note_app/domain/models/note.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class NoteDbHelper {
  final Database db;
  NoteDbHelper({
    required this.db,
  });

  Future<Note?> getNoteById(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      "note",
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Note>> getNotes() async {
    final maps = await db.query("note");
    return maps.map((e) => Note.fromMap(e)).toList();
  }

  Future<void> createNote(Note note) async {
    await db.insert('note', note.toMap());
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      "note",
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(Note note) async {
    await db.delete(
      "note",
      where: "id = ?",
      whereArgs: [note.id],
    );
  }
}
