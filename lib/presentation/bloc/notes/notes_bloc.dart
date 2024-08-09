import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/usecases/notes/note_usecase.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteUsecase noteUsecase;

  NotesBloc({required this.noteUsecase}) : super(NotesState.initial()) {
    on<GetNotesEvent>((event, emit) async {
      emit(state.copyWith(notesGetStatus: NotesGetStatus.loading));
      try {
        List<Note> notes = await noteUsecase.getNotes();
        notes.sort(
          (a, b) => -a.timestamp.compareTo(b.timestamp),
        );
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
          await noteUsecase.deleteNote(event.note);
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
            await noteUsecase.createNote(state.recentlyDeleteNote!);
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
          await noteUsecase.updateNote(event.note);
          emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.success));
          add(GetNotesEvent());
          emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.initail));
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
          await noteUsecase.createNote(event.note);
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.success));
          add(GetNotesEvent());
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.initail));
        } catch (e) {
          print(e);
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.failure));
        }
      },
    );
  }
}
