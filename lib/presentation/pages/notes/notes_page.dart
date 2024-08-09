import 'package:flutter/material.dart';
import 'package:flutter_note_app/config/colors.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter_note_app/presentation/pages/add_edit_note/add_edit_note_page.dart';
import 'package:flutter_note_app/presentation/widgets/note_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteReadBloc = context.watch<NotesBloc>();
    noteReadBloc.add(GetNotesEvent());

    final noteState = noteReadBloc.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your note',
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEditNotePage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: noteState.notes
            .map(
              (e) => NoteItem(
                note: Note(
                  title: e.title,
                  content: e.content,
                  color: e.color,
                  timestamp: e.timestamp,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
