import 'dart:async';

import 'package:flutter/material.dart';

import 'ambiguate.dart';

/// BuildContext extension with some ui utils methods and getters
extension ContextExtensionss on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or
  /// desktop window)
  double get width => mediaQuerySize.width;

  /// return true if the current app mode is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// similar to [MediaQuery.of(context).padding]
  ThemeData get theme => Theme.of(this);

  /// similar to [MediaQuery.of(context).padding]
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// similar to [MediaQuery.of(context).padding]
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  /// similar to [MediaQuery.of(context).padding]
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// similar to [MediaQuery.of(context).viewPadding]
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  /// similar to [MediaQuery.of(context).viewInsets]
  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  /// similar to [MediaQuery.of(context).orientation]
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// check if device is on landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// check if device is on portrait mode
  bool get isPortrait => orientation == Orientation.portrait;

  /// similar to [MediaQuery.of(this).devicePixelRatio]
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// similar to [MediaQuery.of(this).textScaleFactor]
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  /// get the shortestSide from screen
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// True if the shortestSide is smaller than 480p
  bool get isSmallPhone => mediaQueryShortestSide < 480;

  /// True if the shortestSide is smaller than 600p
  bool get isPhone => mediaQueryShortestSide < 600;

  /// True if the shortestSide is largest than 600p
  bool get isSmallTablet => mediaQueryShortestSide >= 600;

  /// True if the shortestSide is largest than 720p
  bool get isLargeTablet => mediaQueryShortestSide >= 720;

  /// True if the current device is Tablet
  bool get isTablet => isSmallTablet || isLargeTablet;
}

/// Add with AfterLayoutMixin<MyWidget> mixin to your State<MyWidget> class and then implement
/// the void afterFirstLayout(BuildContext context) abstract method. Code in this method will be
/// called the first time this widget is laid out on the screen.
mixin AfterFirstLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)?.endOfFrame.then(
      (_) {
        if (mounted) {
          afterFirstLayout(context);
        }
      },
    );
  }

  /// Brings functionality to execute code after the first layout of a widget has been performed,
  /// i.e. after the first frame has been displayed.
  ///
  /// If you want to display a widget that depends on the layout, such as a Dialog or BottomSheet,
  /// you can not use that widget in initState instead of that you can use this method
  FutureOr<void> afterFirstLayout(BuildContext context);
}
