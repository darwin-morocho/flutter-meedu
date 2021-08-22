import 'dart:html';

import 'fake_web_utils.dart';

class WebUtils implements WebUtilsInterface {
  @override
  void pushState(Object? state, String title, String url) {
    window.history.pushState(
      state,
      title,
      url,
    );
  }

  @override
  void replaceState(Object? state, String title, String url) {
    print("set replace url");
    window.history.replaceState(
      state,
      title,
      url,
    );
  }

  @override
  void setTitle(String title) {
    document.title = title;
  }
}
