part of 'notes_bloc.dart';

enum NotesGetStatus { initail, loading, success, failure }

enum NotesDeleteStatus { initail, loading, success, failure }

enum NotesCreateStatus { initail, loading, success, failure }

enum NotesUpdateStatus { initail, loading, success, failure }

class NotesState extends Equatable {
  final List<Note> notes;
  final Note? recentlyDeleteNote;
  final NotesGetStatus notesGetStatus;
  final NotesCreateStatus notesCreateStatus;
  final NotesUpdateStatus notesUpdateStatus;
  final NotesDeleteStatus notesDeleteStatus;
  const NotesState({
    required this.notes,
    this.recentlyDeleteNote,
    required this.notesGetStatus,
    required this.notesCreateStatus,
    required this.notesUpdateStatus,
    required this.notesDeleteStatus,
  });

  factory NotesState.initial() {
    return const NotesState(
      notes: [],
      recentlyDeleteNote: null,
      notesGetStatus: NotesGetStatus.initail,
      notesCreateStatus: NotesCreateStatus.initail,
      notesDeleteStatus: NotesDeleteStatus.initail,
      notesUpdateStatus: NotesUpdateStatus.initail,
    );
  }

  @override
  List<Object?> get props {
    return [
      notes,
      recentlyDeleteNote,
      notesGetStatus,
      notesCreateStatus,
      notesUpdateStatus,
      notesDeleteStatus,
    ];
  }

  NotesState copyWith({
    List<Note>? notes,
    Note? recentlyDeleteNote,
    NotesGetStatus? notesGetStatus,
    NotesCreateStatus? notesCreateStatus,
    NotesUpdateStatus? notesUpdateStatus,
    NotesDeleteStatus? notesDeleteStatus,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      recentlyDeleteNote: recentlyDeleteNote ?? this.recentlyDeleteNote,
      notesGetStatus: notesGetStatus ?? this.notesGetStatus,
      notesCreateStatus: notesCreateStatus ?? this.notesCreateStatus,
      notesUpdateStatus: notesUpdateStatus ?? this.notesUpdateStatus,
      notesDeleteStatus: notesDeleteStatus ?? this.notesDeleteStatus,
    );
  }

  @override
  String toString() {
    return 'NotesState(notes: $notes, recentlyDeleteNote: $recentlyDeleteNote, notesGetStatus: $notesGetStatus, notesCreateStatus: $notesCreateStatus, notesUpdateStatus: $notesUpdateStatus, notesDeleteStatus: $notesDeleteStatus)';
  }
}
