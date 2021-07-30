import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizmate_flutter/api/api_controller.dart';
import 'package:quizmate_flutter/api/category_repo.dart';
import 'package:quizmate_flutter/api/connectivity_repo.dart';
import 'package:quizmate_flutter/api/quiz_repo.dart';
import 'package:quizmate_flutter/bloc/category/category_bloc.dart';
import 'package:quizmate_flutter/bloc/connectivity/ConnectivityBloc.dart';
import 'package:quizmate_flutter/bloc/quiz/quiz_bloc.dart';
import 'package:quizmate_flutter/ui/screens/home.dart';

/// This is the entry point to the application.
void main() {
  runApp(App(APIController()));
}

/// Primary container of the app. Provides instances of the repositories down the app hierarchy.
/// This helps with Dependency Injection.
class App extends StatelessWidget {
  final APIController _apiController;

  const App(this._apiController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ConnectivityRepo(_apiController),
        ),
        RepositoryProvider(
          create: (context) => CategoryRepo(_apiController),
        ),
        RepositoryProvider(
          create: (context) => QuizRepo(_apiController),
        ),
      ],
      child: _QuizMate(),
    );
  }
}

/// Takes repositories passed on from upwards and uses them to provide BLoC instances down the app hierarchy.
/// This also helps with Dependency Injection.
///
/// This is also where the MaterialApp instance containing the actual UIs of the app is initialized
class _QuizMate extends StatelessWidget {
  const _QuizMate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivityRepo = RepositoryProvider.of<ConnectivityRepo>(context);
    final categoryRepo = RepositoryProvider.of<CategoryRepo>(context);
    final quizRepo = RepositoryProvider.of<QuizRepo>(context);

    final categoryBloc = CategoryBloc(categoryRepo);
    final quizBloc = QuizBloc(quizRepo);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(connectivityRepo, [categoryBloc, quizBloc]),
          lazy: false,
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => categoryBloc,
          lazy: false,
        ),
        BlocProvider<QuizBloc>(
          create: (context) => quizBloc,
          lazy: true,
        ),
      ],
      child: MaterialApp(
        title: 'QuizMate',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          primaryColorLight: Colors.blueAccent,
          accentColor: Colors.lightGreen,
          backgroundColor: Color.fromARGB(240, 255, 255, 255),
          textTheme: GoogleFonts.rubikTextTheme(ThemeData.light().textTheme),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          primaryColorLight: Colors.purpleAccent,
          accentColor: Colors.yellow,
          backgroundColor: Colors.white24,
          textTheme: GoogleFonts.rubikTextTheme(ThemeData.dark().textTheme),
        ),
        home: const Home(),
      ),
    );
  }
}
