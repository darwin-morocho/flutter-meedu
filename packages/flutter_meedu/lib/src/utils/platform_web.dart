// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

html.Navigator _navigator = html.window.navigator;

// ignore: avoid_classes_with_only_static_members
class GeneralPlatform {
  static bool get isWeb => true;

  static bool get isMacOS =>
      _navigator.appVersion.contains('Mac OS') && !GeneralPlatform.isIOS;

  static bool get isWindows => _navigator.appVersion.contains('Win');

  static bool get isLinux =>
      (_navigator.appVersion.contains('Linux') ||
          _navigator.appVersion.contains('x11')) &&
      !isAndroid;

  // @check https://developer.chrome.com/multidevice/user-agent
  static bool get isAndroid => _navigator.appVersion.contains('Android ');

  static bool get isIOS {
    bool hasMatch(String? value, String pattern) {
      return (value == null) ? false : RegExp(pattern).hasMatch(value);
    }

    if (hasMatch(_navigator.platform ?? '', r'/iPad|iPhone|iPod/')) {
      return true;
    }
    // maxTouchPoints is needed to separate iPad iOS13 vs new MacOS
    if (_navigator.platform == 'MacIntel' &&
        _navigator.maxTouchPoints != null) {
      return _navigator.maxTouchPoints! > 1;
    }

    return false;
  }

  static bool get isFuchsia => false;

  static bool get isDesktop => isMacOS || isWindows || isLinux;
}
