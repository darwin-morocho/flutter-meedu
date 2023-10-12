import 'package:flutter_meedu/providers.dart';
import 'splash_controller.dart';

final splashProvider = StateNotifierProvider<SplashNotifier, String?>(
  (_) => SplashNotifier(null)..init(),
);
