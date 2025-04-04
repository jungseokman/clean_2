part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class GetNotesEvent extends NotesEvent {
  final NotesOrder? order;
  final NotesType? type;

  const GetNotesEvent({
    this.order,
    this.type,
  });

  @override
  List<Object> get props => [
        order ?? NotesOrder.date,
        type ?? NotesType.desc,
      ];
}

class DeleteNotesEvent extends NotesEvent {
  final Note note;
  const DeleteNotesEvent({
    required this.note,
  });

  @override
  List<Object> get props => [note];
}

class RestoreNotesEvent extends NotesEvent {}

class UpdateNotesEvent extends NotesEvent {
  final Note note;
  const UpdateNotesEvent({
    required this.note,
  });

  @override
  List<Object> get props => [note];
}

class CreateNotesEvent extends NotesEvent {
  final Note note;
  const CreateNotesEvent({
    required this.note,
  });

  @override
  List<Object> get props => [note];
}
