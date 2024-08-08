import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotesPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotesPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
