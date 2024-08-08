import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

class UpdateNote {
  final NoteRepository repository;
  UpdateNote({
    required this.repository,
  });

  Future<void> call(Note note) async {
    await repository.updateNote(note);
  }
}
