import 'package:flutter/material.dart';
import 'package:flutter_note_app/config/colors.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/presentation/widgets/note_item.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          NoteItem(
            note: Note(
              title: "title1",
              content: "content1",
              color: wisteria.value,
              timestamp: 1,
            ),
          ),
          NoteItem(
            note: Note(
              title: "title2",
              content: "content2",
              color: skyBlue.value,
              timestamp: 2,
            ),
          ),
        ],
      ),
    );
  }
}
