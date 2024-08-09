import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/data/datasources/note_db_helper.dart';
import 'package:flutter_note_app/data/repositories/note_repository_impl.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';
import 'package:sqflite/sqflite.dart';

class NoteDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider() async {
    Database database = await createDatabase();
    return [
      RepositoryProvider<NoteDbHelper>(
        create: (context) => NoteDbHelper(db: database),
      ),
      RepositoryProvider<NoteRepository>(
        create: (context) => NoteRepositoryImpl(
          db: RepositoryProvider.of<NoteDbHelper>(context),
        ),
      ),
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BlocProvider<NotesBloc>(
        create: (context) => NotesBloc(
          RepositoryProvider.of<NoteRepository>(context),
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
