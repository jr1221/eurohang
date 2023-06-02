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
      name: 'Start',
      factory: $StartRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'settings',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'load',
          factory: $LoadHangmanRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'play/:question',
          factory: $HangmanRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'browse',
          factory: $BrowseQuestionsRouteExtension._fromState,
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

extension $LoadHangmanRouteExtension on LoadHangmanRoute {
  static LoadHangmanRoute _fromState(GoRouterState state) => LoadHangmanRoute(
        questionId:
            _$convertMapValue('question-id', state.queryParameters, int.parse),
      );

  String get location => GoRouteData.$location(
        '/load',
        queryParams: {
          if (questionId != null) 'question-id': questionId!.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $HangmanRouteExtension on HangmanRoute {
  static HangmanRoute _fromState(GoRouterState state) => HangmanRoute(
        question: state.pathParameters['question']!,
      );

  String get location => GoRouteData.$location(
        '/play/${Uri.encodeComponent(question)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

extension $BrowseQuestionsRouteExtension on BrowseQuestionsRoute {
  static BrowseQuestionsRoute _fromState(GoRouterState state) =>
      const BrowseQuestionsRoute();

  String get location => GoRouteData.$location(
        '/browse',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
