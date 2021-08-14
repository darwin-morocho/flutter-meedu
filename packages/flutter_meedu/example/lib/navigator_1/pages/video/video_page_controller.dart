import 'package:flutter_meedu/meedu.dart';
import 'package:video_player/video_player.dart';

class VideoPageController extends SimpleNotifier {
  final VideoPlayerController _controller = VideoPlayerController.network(
    'https://samplelib.com/lib/preview/mp4/sample-10s.mp4',
  );

  bool _initialized = false;
  bool get initialized => _initialized;

  VideoPlayerController get videoPlayerController => _controller;

  Future<void> play() async {
    await _controller.initialize();
    _initialized = true;
    _controller.play();
    notify();
  }

  @override
  void dispose() {
    _controller.dispose();
    print("video disposed");
    super.dispose();
  }
}
