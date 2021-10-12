part of 'router.dart';

/// return null if default transition must be used
///
/// [transitionDuration] is ignored when transition is equals to Transition.material or Transition.cupertino
///
/// [backGestureEnabled] not works on Android if transition is Transition.material
MeeduPageRoute<T>? _buildNamedRoute<T>({
  required String routeName,
  required Object? arguments,
  required bool backGestureEnabled,
  required Transition? transition,
  required Duration? transitionDuration,
}) {
  _validateRouterState();
  if (appKey.currentWidget == null) {
    return null;
  }
  final app = appKey.currentWidget;
  Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  if (app is MaterialApp) {
    onGenerateRoute = app.onGenerateRoute;
  } else if (app is CupertinoApp) {
    onGenerateRoute = app.onGenerateRoute;
  }

  // if the MaterialApp or CupertinoApp is using onGenerateRoute custom
  // transitions are not allowed
  if (onGenerateRoute != null) {
    return null;
  }

  final _transition = transition ?? MeeduNavigator.i.transition;
  if (_transition == Transition.material ||
      _transition == Transition.cupertino) {
    return null;
  }
  final _transitionDuration =
      transitionDuration ?? MeeduNavigator.i.transitionDuration;

  // create a custom route with a custom transition
  return MeeduPageRoute<T>(
    routeName: routeName,
    settings: RouteSettings(
      name: routeName,
      arguments: arguments,
    ),
    maintainState: true,
    transitionDuration:
        _transition == Transition.none ? Duration.zero : _transitionDuration,
    fullscreenDialog: false,
    transition: _transition,
    backGestureEnabled: backGestureEnabled,
  )..build();
}
