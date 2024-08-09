import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class GetNotes {
  final NoteRepository repository;
  GetNotes({
    required this.repository,
  });

  Future<List<Note>> call() async {
    List<Note> notes = await repository.getNotes();
    notes.sort(
      (a, b) => -a.timestamp.compareTo(b.timestamp),
    );
    return notes;
  }
}
