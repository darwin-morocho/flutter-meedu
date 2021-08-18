

class BackButtonResponse {
  /// set false if pop event for the current route is denied
  final bool allowPop;

  /// result data for pop events
  final dynamic result;

  BackButtonResponse({
    required this.allowPop,
    required this.result,
  });
}
