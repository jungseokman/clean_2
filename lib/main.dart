import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/config/colors.dart';
import 'package:flutter_note_app/di/di_setup.dart';
import 'package:flutter_note_app/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter_note_app/presentation/pages/notes/notes_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<NotesBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: darkGray,
          canvasColor: darkGray,
          floatingActionButtonTheme:
              Theme.of(context).floatingActionButtonTheme.copyWith(
                    backgroundColor: Colors.white,
                    foregroundColor: darkGray,
                  ),
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                backgroundColor: darkGray,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                actionsIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: const NotesPage(),
      ),
    );
  }
}
