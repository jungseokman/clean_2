import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/data/datasources/note_db_helper.dart';
import 'package:flutter_note_app/data/repositories/note_repository_impl.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:flutter_note_app/domain/usecases/notes/create_note.dart';
import 'package:flutter_note_app/domain/usecases/notes/delete_note.dart';
import 'package:flutter_note_app/domain/usecases/notes/get_note.dart';
import 'package:flutter_note_app/domain/usecases/notes/get_notes.dart';
import 'package:flutter_note_app/domain/usecases/notes/note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/notes/update_note.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';
import 'package:sqflite/sqflite.dart';

class NoteDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider() async {
    Database database = await createDatabase();
    final noteDbHelper = NoteDbHelper(db: database);
    final noteRepository = NoteRepositoryImpl(db: noteDbHelper);
    final noteUsecase = NoteUsecase(
      getNote: GetNote(
        repository: noteRepository,
      ),
      createNote: CreateNote(
        repository: noteRepository,
      ),
      deleteNote: DeleteNote(
        repository: noteRepository,
      ),
      updateNote: UpdateNote(
        repository: noteRepository,
      ),
      getNotes: GetNotes(
        repository: noteRepository,
      ),
    );

    return [
      RepositoryProvider<NoteDbHelper>.value(value: noteDbHelper),
      RepositoryProvider<NoteRepository>.value(value: noteRepository),
      RepositoryProvider<NoteUsecase>.value(value: noteUsecase),
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BlocProvider<NotesBloc>(
        create: (context) => NotesBloc(
          noteUsecase: RepositoryProvider.of<NoteUsecase>(context),
        ),
      ),
    ];
  }
}

Future<Database> createDatabase() async {
  return await openDatabase(
    "note_db",
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)");
    },
  );
}
