part of 'note_app_bloc.dart';

abstract class NoteAppState extends Equatable {
  const NoteAppState();  

  @override
  List<Object> get props => [];
}
class NoteAppInitial extends NoteAppState {}
