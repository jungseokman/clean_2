import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetNote {
  final NoteRepository repository;
  GetNote({
    required this.repository,
  });

  Future<Note?> call(int id) async {
    return await repository.getNoteById(id);
  }
}
