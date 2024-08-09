import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/di/note_di.dart';

class MainDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider() async {
    List<RepositoryProvider> noteRepositoryProviders =
        await NoteDi.getRepositoryProvider();

    return [
      ...noteRepositoryProviders,
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      ...NoteDi.getBlocProvider(),
    ];
  }
}
