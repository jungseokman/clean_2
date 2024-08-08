import 'package:flutter/material.dart';

class AddEditNotePage extends StatelessWidget {
  const AddEditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddEditNotePage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddEditNotePage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
