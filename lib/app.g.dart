// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $startRoute,
    ];

RouteBase get $startRoute => GoRouteData.$route(
      path: '/',
      factory: $StartRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'settings',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'hangman/:questionId',
          factory: $HangmanRouteExtension._fromState,
        ),
      ],
    );

extension $StartRouteExtension on StartRoute {
  static StartRoute _fromState(GoRouterState state) => const StartRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $HangmanRouteExtension on HangmanRoute {
  static HangmanRoute _fromState(GoRouterState state) => HangmanRoute(
        questionId: int.parse(state.pathParameters['questionId']!),
      );

  String get location => GoRouteData.$location(
        '/hangman/${Uri.encodeComponent(questionId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}
