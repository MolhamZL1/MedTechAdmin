import 'package:video_player/video_player.dart';

Future<Duration?> getVideoDurationFromUrl(String url) async {
  final controller = VideoPlayerController.networkUrl(Uri.parse(url));

  try {
    await controller.initialize();
    final duration = controller.value.duration;
    await controller.dispose();
    return duration;
  } catch (e) {
    print('Error getting video duration: $e');
    return null;
  }
}
