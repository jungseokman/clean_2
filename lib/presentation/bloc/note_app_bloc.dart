import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_app_event.dart';
part 'note_app_state.dart';

class NoteAppBloc extends Bloc<NoteAppEvent, NoteAppState> {
  NoteAppBloc() : super(NoteAppInitial()) {
    on<NoteAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
