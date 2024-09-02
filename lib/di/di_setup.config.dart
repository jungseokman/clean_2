// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_note_app/data/datasources/note_db_helper.dart' as _i158;
import 'package:flutter_note_app/data/repositories/note_repository_impl.dart'
    as _i978;
import 'package:flutter_note_app/di/app_module.dart' as _i148;
import 'package:flutter_note_app/domain/repositories/note_repository.dart'
    as _i1020;
import 'package:flutter_note_app/domain/usecases/notes/create_note.dart'
    as _i757;
import 'package:flutter_note_app/domain/usecases/notes/delete_note.dart'
    as _i1062;
import 'package:flutter_note_app/domain/usecases/notes/get_note.dart' as _i553;
import 'package:flutter_note_app/domain/usecases/notes/get_notes.dart' as _i548;
import 'package:flutter_note_app/domain/usecases/notes/note_usecase.dart'
    as _i819;
import 'package:flutter_note_app/domain/usecases/notes/update_note.dart'
    as _i326;
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart'
    as _i311;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i779.Database>(
      () => appModule.db,
      preResolve: true,
    );
    gh.singleton<_i158.NoteDbHelper>(
        () => _i158.NoteDbHelper(db: gh<_i779.Database>()));
    gh.singleton<_i1020.NoteRepository>(
        () => _i978.NoteRepositoryImpl(db: gh<_i158.NoteDbHelper>()));
    gh.singleton<_i326.UpdateNote>(
        () => _i326.UpdateNote(repository: gh<_i1020.NoteRepository>()));
    gh.singleton<_i553.GetNote>(
        () => _i553.GetNote(repository: gh<_i1020.NoteRepository>()));
    gh.singleton<_i757.CreateNote>(
        () => _i757.CreateNote(repository: gh<_i1020.NoteRepository>()));
    gh.singleton<_i1062.DeleteNote>(
        () => _i1062.DeleteNote(repository: gh<_i1020.NoteRepository>()));
    gh.singleton<_i548.GetNotes>(
        () => _i548.GetNotes(repository: gh<_i1020.NoteRepository>()));
    gh.singleton<_i819.NoteUsecase>(() => _i819.NoteUsecase(
          getNote: gh<_i553.GetNote>(),
          createNote: gh<_i757.CreateNote>(),
          deleteNote: gh<_i1062.DeleteNote>(),
          updateNote: gh<_i326.UpdateNote>(),
          getNotes: gh<_i548.GetNotes>(),
        ));
    gh.singleton<_i311.NotesBloc>(
        () => _i311.NotesBloc(noteUsecase: gh<_i819.NoteUsecase>()));
    return this;
  }
}

class _$AppModule extends _i148.AppModule {}
