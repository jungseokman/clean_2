import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/repositories/note_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository repository;

  NotesBloc(
    this.repository,
  ) : super(NotesState.initial()) {
    on<GetNotesEvent>((event, emit) async {
      emit(state.copyWith(notesGetStatus: NotesGetStatus.loading));
      try {
        List<Note> notes = await repository.getNotes();
        emit(state.copyWith(
            notes: notes, notesGetStatus: NotesGetStatus.success));
      } catch (e) {
        print(e);
        emit(state.copyWith(notesGetStatus: NotesGetStatus.failure));
      }
    });

    on<DeleteNotesEvent>(
      (event, emit) async {
        emit(state.copyWith(notesDeleteStatus: NotesDeleteStatus.loading));
        try {
          await repository.deleteNote(event.note);
          emit(state.copyWith(
            notesDeleteStatus: NotesDeleteStatus.success,
            recentlyDeleteNote: event.note,
          ));
          add(GetNotesEvent());
        } catch (e) {
          print(e);
          emit(state.copyWith(notesDeleteStatus: NotesDeleteStatus.failure));
        }
      },
    );

    on<RestoreNotesEvent>(
      (event, emit) async {
        if (state.recentlyDeleteNote != null) {
          try {
            await repository.createNote(state.recentlyDeleteNote!);
            emit(state.copyWith(recentlyDeleteNote: null));
            add(GetNotesEvent());
          } catch (e) {
            print(e);
          }
        }
      },
    );

    on<UpdateNotesEvent>(
      (event, emit) async {
        emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.loading));
        try {
          await repository.createNote(event.note);
          emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.success));
          add(GetNotesEvent());
        } catch (e) {
          print(e);
          emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.failure));
        }
      },
    );

    on<CreateNotesEvent>(
      (event, emit) async {
        emit(state.copyWith(notesCreateStatus: NotesCreateStatus.loading));

        try {
          await repository.createNote(event.note);
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.success));
          add(GetNotesEvent());
        } catch (e) {
          print(e);
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.failure));
        }
      },
    );
  }
}
