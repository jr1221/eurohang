import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:eurohang/question.dart';
import 'package:eurohang/settings.dart';
import 'package:eurohang/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../constants.dart';
import 'browse_questions.dart';
import 'hangman.dart';

part 'app.g.dart';

@TypedGoRoute<StartRoute>(
  path: '/',
  name: 'Start',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SettingsRoute>(
      path: 'settings',
    ),
    TypedGoRoute<LoadHangmanRoute>(
      path: 'hangman',
    ),
    TypedGoRoute<HangmanRoute>(
      path: 'play/:question',
    ),
    TypedGoRoute<BrowseQuestionsRoute>(
      path: 'browse',
    ),
  ],
)
class StartRoute extends GoRouteData {
  const StartRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const StartScreen();
}

class LoadHangmanRoute extends GoRouteData {
  const LoadHangmanRoute({this.questionId});

  final int? questionId;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final question = await rootBundle.loadString(
        '${ProjectConstants.definitionsPath}${questionId ?? (Random().nextInt(ProjectConstants.numberOfQuestions) + 1)}.json');
    return HangmanRoute(question: question).location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eurohang'),
          centerTitle: true,
        ),
        body: const SingleChildScrollView());
  }
}

class HangmanRoute extends GoRouteData {
  const HangmanRoute({required this.question});
  final String question;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HangmanScreen(
      question: Question.fromJson(
        jsonDecode(question),
      ),
    );
  }
}

class BrowseQuestionsRoute extends GoRouteData {
  const BrowseQuestionsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BrowseQuestionsScreen();
  }
}

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

final _router = GoRouter(
    initialLocation: '/', debugLogDiagnostics: false, routes: $appRoutes);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<String>>(
      valueListenable: Hive.box<String>(ProjectConstants
              .settingsBoxKey) // Listen to darkMode and colorScheme hive changes
          .listenable(
        keys: [
          ProjectConstants.darkModeStorageKey,
          ProjectConstants.colorSchemeStorageKey,
        ],
      ),
      builder: (context, box, widget) {
        bool? darkMode;
        switch (box.get(ProjectConstants.darkModeStorageKey,
            defaultValue: 'unset')) {
          case 'true': // darkMode ON
            darkMode = true;
            break;
          case 'false': // darkMode OFF
            darkMode = false;
            break;
          case 'unset': // darkMode platform preference
            darkMode = null;
            break;
          default: // Shouldn't reach
            throw UnimplementedError(
                'Didn\'t find parsable type for dark mode!');
        }

        // If no colorScheme in hive, put blueGrey as default
        if (box.get(ProjectConstants.colorSchemeStorageKey) == null) {
          box.put(ProjectConstants.colorSchemeStorageKey,
              Colors.blueGrey.value.toString());
        }

        // get colorScheme color from hive, default to blueGrey (shouldn't need)
        final colorSchemeColor = Color(int.parse(box.get(
            ProjectConstants.colorSchemeStorageKey,
            defaultValue: Colors.blueGrey.value.toString())!));

        return MaterialApp.router(
          title: 'Eurohang',
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          builder: BotToastInit(),
          theme: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: colorSchemeColor, brightness: Brightness.light),
          ),
          darkTheme: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: colorSchemeColor, brightness: Brightness.dark),
          ),
          // darkMode ON or OFF if manually set, else use platform mode
          themeMode: (darkMode ??
                  View.of(context).platformDispatcher.platformBrightness ==
                      Brightness.dark)
              ? ThemeMode.dark
              : ThemeMode.light,
        );
      },
    );
  }
}
