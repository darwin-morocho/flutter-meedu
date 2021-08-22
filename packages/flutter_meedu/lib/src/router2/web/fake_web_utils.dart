class WebUtils implements WebUtilsInterface {
  @override
  void pushState(Object? state, String title, String url) {
    // TODO: implement pushState
  }

  @override
  void replaceState(Object? state, String title, String url) {
    // TODO: implement replaceState
  }

  @override
  void setTitle(String title) {
    // TODO: implement setTitle
  }
}

abstract class WebUtilsInterface {
  void pushState(Object? state, String title, String url);
  void replaceState(Object? state, String title, String url);
  void setTitle(String title);
}
