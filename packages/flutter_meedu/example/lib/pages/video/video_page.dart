import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:meedu_example/pages/video/video_page_controller.dart';
import 'package:video_player/video_player.dart';

final videoPageProvider = SimpleProvider((_) => VideoPageController());

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (_, watch, __) {
        final controller = watch(videoPageProvider);

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: controller.initialized
                  ? VideoPlayer(
                      controller.videoPlayerController,
                    )
                  : Container(
                      color: Colors.black,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                controller.play();
              },
              child: Text("play"),
            )
          ],
        );
      }),
    );
  }
}
