import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter_note_app/presentation/pages/add_edit_note/add_edit_note_page.dart';
import 'package:flutter_note_app/presentation/widgets/note_item.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _showMenu = false;
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(const GetNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final noteReadBloc = context.watch<NotesBloc>();
    final noteState = noteReadBloc.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your note',
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _showMenu = !_showMenu;
                });
              },
              icon: const Icon(Icons.sort)),
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
        children: [
          if (_showMenu)
            Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: NotesOrder.color,
                      groupValue: context.read<NotesBloc>().state.notesOrder,
                      onChanged: (value) {
                        context
                            .read<NotesBloc>()
                            .add(GetNotesEvent(order: value));
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Text(
                      '색상',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio(
                      value: NotesOrder.date,
                      groupValue: context.read<NotesBloc>().state.notesOrder,
                      onChanged: (value) {
                        context
                            .read<NotesBloc>()
                            .add(GetNotesEvent(order: value));
                      },
                    ),
                    const Text(
                      '날짜',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio(
                      value: NotesOrder.title,
                      groupValue: context.read<NotesBloc>().state.notesOrder,
                      onChanged: (value) {
                        context
                            .read<NotesBloc>()
                            .add(GetNotesEvent(order: value));
                      },
                    ),
                    const Text(
                      '제목',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: NotesType.desc,
                      groupValue: context.read<NotesBloc>().state.notesType,
                      onChanged: (value) {
                        context
                            .read<NotesBloc>()
                            .add(GetNotesEvent(type: value));
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Text(
                      '최신순',
                      style: TextStyle(color: Colors.white),
                    ),
                    Radio(
                      value: NotesType.asc,
                      groupValue: context.read<NotesBloc>().state.notesType,
                      onChanged: (value) {
                        context
                            .read<NotesBloc>()
                            .add(GetNotesEvent(type: value));
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const Text(
                      '오래된순',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ...noteState.notes.map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditNotePage(
                        note: e,
                      ),
                    ));
              },
              child: NoteItem(
                onDeleteTap: () {
                  noteReadBloc.add(DeleteNotesEvent(note: e));

                  final snackBar = SnackBar(
                    content: const Text("노트가 삭제되었습니다."),
                    action: SnackBarAction(
                        label: '취소',
                        onPressed: () {
                          noteReadBloc.add(RestoreNotesEvent());
                        }),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                note: Note(
                  title: e.title,
                  content: e.content,
                  color: e.color,
                  timestamp: e.timestamp,
                  id: e.id,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
