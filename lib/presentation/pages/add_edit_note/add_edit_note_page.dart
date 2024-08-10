import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/config/colors.dart';
import 'package:flutter_note_app/domain/models/note.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final List<Color> noteColor = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion
  ];

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController contentEditingController =
      TextEditingController();

  Color color = roseBud;
  int? id;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      textEditingController.text = widget.note!.title;
      contentEditingController.text = widget.note!.content;
      color = Color(widget.note!.color);
      id = widget.note!.id;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    contentEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteReadBloc = context.read<NotesBloc>();
    return BlocListener<NotesBloc, NotesState>(
      listener: (context, state) {
        if ((state.notesUpdateStatus == NotesUpdateStatus.success ||
                state.notesCreateStatus == NotesCreateStatus.success) &&
            Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: color,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            DateTime now = DateTime.now();
            int formattedDate = int.parse('${now.year}'
                '${now.month.toString().padLeft(2, '0')}'
                '${now.day.toString().padLeft(2, '0')}'
                '${now.hour.toString().padLeft(2, '0')}'
                '${now.minute.toString().padLeft(2, '0')}'
                '${now.second.toString().padLeft(2, '0')}');
            if (textEditingController.text.isEmpty ||
                contentEditingController.text.isEmpty) {
              const snackBar = SnackBar(content: Text("제목이나 내용이 비어 있습니다."));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            if (widget.note == null) {
              noteReadBloc.add(CreateNotesEvent(
                  note: Note(
                title: textEditingController.text,
                content: contentEditingController.text,
                color: color.value,
                timestamp: formattedDate,
              )));
            } else {
              noteReadBloc.add(UpdateNotesEvent(
                  note: Note(
                id: id,
                title: textEditingController.text,
                content: contentEditingController.text,
                color: color.value,
                timestamp: formattedDate,
              )));
            }
          },
          child: const Icon(Icons.save),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  noteColor.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          color = noteColor[index];
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: noteColor[index],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 3),
                              blurRadius: 5,
                            ),
                          ],
                          border: color == noteColor[index]
                              ? Border.all(color: darkGray, width: 3)
                              : null,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              TextField(
                controller: textEditingController,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: darkGray,
                    ),
                decoration: const InputDecoration(
                  hintText: "제목을 입력하세요",
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: contentEditingController,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: darkGray,
                    ),
                decoration: const InputDecoration(
                  hintText: "내용을 입력하세요",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
