part of 'notes_bloc.dart';

enum NotesGetStatus { initail, loading, success, failure }

enum NotesDeleteStatus { initail, loading, success, failure }

enum NotesCreateStatus { initail, loading, success, failure }

enum NotesUpdateStatus { initail, loading, success, failure }

enum NotesOrder { title, date, color }

enum NotesType { asc, desc }

class NotesState extends Equatable {
  final List<Note> notes;
  final Note? recentlyDeleteNote;
  final NotesGetStatus notesGetStatus;
  final NotesCreateStatus notesCreateStatus;
  final NotesUpdateStatus notesUpdateStatus;
  final NotesDeleteStatus notesDeleteStatus;
  final NotesOrder notesOrder;
  final NotesType notesType;

  const NotesState({
    required this.notes,
    this.recentlyDeleteNote,
    required this.notesGetStatus,
    required this.notesCreateStatus,
    required this.notesUpdateStatus,
    required this.notesDeleteStatus,
    required this.notesOrder,
    required this.notesType,
  });

  factory NotesState.initial() {
    return const NotesState(
      notes: [],
      recentlyDeleteNote: null,
      notesGetStatus: NotesGetStatus.initail,
      notesCreateStatus: NotesCreateStatus.initail,
      notesDeleteStatus: NotesDeleteStatus.initail,
      notesUpdateStatus: NotesUpdateStatus.initail,
      notesOrder: NotesOrder.date,
      notesType: NotesType.desc,
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
      notesOrder,
      notesType,
    ];
  }

  NotesState copyWith({
    List<Note>? notes,
    Note? recentlyDeleteNote,
    NotesGetStatus? notesGetStatus,
    NotesCreateStatus? notesCreateStatus,
    NotesUpdateStatus? notesUpdateStatus,
    NotesDeleteStatus? notesDeleteStatus,
    NotesOrder? notesOrder,
    NotesType? notesType,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      recentlyDeleteNote: recentlyDeleteNote ?? this.recentlyDeleteNote,
      notesGetStatus: notesGetStatus ?? this.notesGetStatus,
      notesCreateStatus: notesCreateStatus ?? this.notesCreateStatus,
      notesUpdateStatus: notesUpdateStatus ?? this.notesUpdateStatus,
      notesDeleteStatus: notesDeleteStatus ?? this.notesDeleteStatus,
      notesOrder: notesOrder ?? this.notesOrder,
      notesType: notesType ?? this.notesType,
    );
  }

  @override
  String toString() {
    return 'NotesState(notes: $notes, recentlyDeleteNote: $recentlyDeleteNote, notesGetStatus: $notesGetStatus, notesCreateStatus: $notesCreateStatus, notesUpdateStatus: $notesUpdateStatus, notesDeleteStatus: $notesDeleteStatus, notesOrder: $notesOrder, notesType: $notesType)';
  }
}
