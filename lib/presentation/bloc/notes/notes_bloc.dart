import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/domain/usecases/notes/note_usecase.dart';
import 'package:injectable/injectable.dart';

part 'notes_event.dart';
part 'notes_state.dart';

@singleton
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteUsecase noteUsecase;

  NotesBloc({required this.noteUsecase}) : super(NotesState.initial()) {
    on<GetNotesEvent>((event, emit) async {
      emit(state.copyWith(notesGetStatus: NotesGetStatus.loading));
      try {
        final order = event.order ?? state.notesOrder;
        final type = event.type ?? state.notesType;

        List<Note> notes = await noteUsecase.getNotes(order, type);

        emit(state.copyWith(
          notes: notes,
          notesOrder: event.order,
          notesType: event.type,
          notesGetStatus: NotesGetStatus.success,
        ));
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
          add(const GetNotesEvent());
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
            add(const GetNotesEvent());
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
          add(const GetNotesEvent());
        } catch (e) {
          print(e);
          emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.failure));
        }

        emit(state.copyWith(notesUpdateStatus: NotesUpdateStatus.initail));
      },
    );

    on<CreateNotesEvent>(
      (event, emit) async {
        emit(state.copyWith(notesCreateStatus: NotesCreateStatus.loading));

        try {
          await noteUsecase.createNote(event.note);
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.success));
          add(const GetNotesEvent());
        } catch (e) {
          print(e);
          emit(state.copyWith(notesCreateStatus: NotesCreateStatus.failure));
        }

        emit(state.copyWith(notesCreateStatus: NotesCreateStatus.initail));
      },
    );
  }
}
