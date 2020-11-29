import 'package:flutter/material.dart';
import 'package:meedu/meedu.dart';

/// Push the given [page] onto the navigator.
Future<T> push<T>(Widget page, {Object arguments}) {
  final name = "/${page.runtimeType.toString()}";
  final Route route = MaterialPageRoute(
    builder: (_) => page,
    settings: RouteSettings(
      name: name,
      arguments: arguments,
    ),
  );
  return MNavigator.instance.state.push(route);
}

/// Replace the current [page] of the navigator by pushing the given [page] and then
///  disposing the previous route once the new route has finished animating in.
Future<T> pushReplacement<T>(Widget page, {Object arguments}) {
  final name = "/${page.runtimeType.toString()}";
  final Route route = MaterialPageRoute(
    builder: (_) => page,
    settings: RouteSettings(
      name: name,
      arguments: arguments,
    ),
  );
  return MNavigator.instance.state.pushReplacement(route);
}

/// Push a named route onto the navigator.
Future<T> pushNamed<T>(String routeName, {Object arguments}) {
  return MNavigator.instance.state.pushNamed<T>(routeName, arguments: arguments);
}

/// Pop the current route off the navigator and push a named route in its place
Future<T> popAndPushNamed<T>(String routeName, {Object arguments}) {
  return MNavigator.instance.state.popAndPushNamed(routeName, arguments: arguments);
}

/// replace the current page with a new route name
Future<T> pushReplacementNamed<T>(String routeName, {Object arguments}) {
  return MNavigator.instance.state.pushReplacementNamed(routeName, arguments: arguments);
}

/// navigates to a new pages and remove until
Future<T> pushNamedAndRemoveUntil<T>(
  String routeName, {
  bool Function(Route<dynamic>) predicate,
  Object arguments,
}) {
  return MNavigator.instance.state.pushNamedAndRemoveUntil(routeName, predicate ?? () => false, arguments: arguments);
}

/// remove all pages in the stack until [predicate]
void popUntil([bool Function(Route<dynamic>) predicate]) {
  MNavigator.instance.state.popUntil(predicate ?? () => false);
}

/// return true if we can do pop
bool canPop() => MNavigator.instance.state.canPop();

/// return the arguments of the current page
Object arguments(BuildContext context) {
  return ModalRoute.of(context).settings.arguments;
}
