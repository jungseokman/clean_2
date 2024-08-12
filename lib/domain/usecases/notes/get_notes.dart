import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';

class GetNotes {
  final NoteRepository repository;
  GetNotes({
    required this.repository,
  });

  Future<List<Note>> call(NotesOrder order, NotesType type) async {
    List<Note> notes = await repository.getNotes();

    switch (order) {
      case NotesOrder.date:
        notes.sort(
          (a, b) => type == NotesType.asc
              ? a.timestamp.compareTo(b.timestamp)
              : b.timestamp.compareTo(a.timestamp),
        );
        break;
      case NotesOrder.title:
        notes.sort(
          (a, b) => type == NotesType.asc
              ? a.title.compareTo(b.title)
              : b.title.compareTo(a.title),
        );

        break;

      case NotesOrder.color:
        notes.sort(
          (a, b) => type == NotesType.asc
              ? a.color.compareTo(b.color)
              : b.color.compareTo(a.color),
        );
        break;

      default:
    }

    return notes;
  }
}
