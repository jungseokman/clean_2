import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class CreateNote {
  final NoteRepository repository;
  CreateNote({
    required this.repository,
  });

  Future<void> call(Note note) async {
    await repository.createNote(note);
  }
}
