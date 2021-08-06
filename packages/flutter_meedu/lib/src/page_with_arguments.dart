import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        Key,
        ModalRoute,
        RouteSettings,
        State,
        StatefulWidget,
        Widget;

/// A simple Widget with a callback useful to set arguments for one SimpleProvider or a StateProvider
/// ```dart
/// PageWithArguments(
///   onReady: (RouteSettings settings) {
///     final arguments = settings.arguments;
///     tabsProvider.setArguments(arguments);
///   },
///   child: TabsPage(),
/// );
/// ```
class PageWithArguments extends StatefulWidget {
  final Widget Function(BuildContext context) builder;

  /// callback that contains the current route [settings], you can use this callback
  /// to get the [arguments] for one route with our rebuild when
  /// pushNamedAndRemoveUntil or  pushAndRemoveUntil are called.
  final void Function(RouteSettings settings) onReady;

  const PageWithArguments({
    Key? key,
    required this.onReady,
    required this.builder,
  }) : super(key: key);

  @override
  _PageWithArgumentsState createState() => _PageWithArgumentsState();
}

class _PageWithArgumentsState extends State<PageWithArguments> {
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_ready) {
      widget.onReady(ModalRoute.of(context)!.settings);
      _ready = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

/// uses this class to create a page and define the arguments for a SimpleProvider or a StateProvider
///
/// ``` dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_meedu/meedu.dart';
/// import 'package:flutter_meedu/page.dart';
///
/// final loginProvider = SimpleProvider(
///   (ref) => LoginController(ref.arguments),
/// );
///
/// class LoginPage extends PageWithArgumentsWidget {
///   const LoginPage({Key? key}) : super(key: key);
///
///   @override
///   void onInit(RouteSettings settings) {
///     /// you can use settings to get data passed as an argument
///     /// using Navigator.pushName(context,'rpute-name', arguments: data);
///     loginProvider.setArguments(settings.arguments);
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       .
///       .
///       .
///     );
///   }
/// }
/// ```
abstract class PageWithArgumentsWidget extends StatefulWidget {
  const PageWithArgumentsWidget({
    Key? key,
  }) : super(key: key);

  void onInit(RouteSettings settings);
  Widget build(BuildContext context);

  @override
  _PageWithArgumentsWidgetState createState() =>
      _PageWithArgumentsWidgetState();
}

class _PageWithArgumentsWidgetState extends State<PageWithArgumentsWidget> {
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_ready) {
      widget.onInit(ModalRoute.of(context)!.settings);
      _ready = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
