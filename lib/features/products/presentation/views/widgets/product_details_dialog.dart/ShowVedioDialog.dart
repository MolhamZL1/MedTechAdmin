import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/CustomCircleLoading.dart';
import 'package:video_player/video_player.dart';

import '../../../../domain/entities/vedio_entity.dart';

class ShowVedioDialog extends StatefulWidget {
  const ShowVedioDialog({super.key, required this.vedioEntity});
  final VedioEntity vedioEntity;

  @override
  State<ShowVedioDialog> createState() => _ShowVedioDialogState();
}

class _ShowVedioDialogState extends State<ShowVedioDialog> {
  late VideoPlayerController controller;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.vedioEntity.url),
      )
      ..initialize().then((_) {
        setState(() {});
        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    widget.vedioEntity.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),

            Divider(color: Colors.grey, thickness: 0.4, height: 0),

            /// Video + Controls
            if (controller.value.isInitialized)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: VideoPlayer(controller),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Slider
                    VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.blue,
                        backgroundColor: Colors.grey[300]!,
                        bufferedColor: Colors.grey[500]!,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Buttons: Play/Pause + Mute
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: () {
                            setState(() {
                              controller.value.isPlaying
                                  ? controller.pause()
                                  : controller.play();
                            });
                          },
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: Icon(
                            isMuted ? Icons.volume_off : Icons.volume_up,
                          ),
                          onPressed: () {
                            setState(() {
                              isMuted = !isMuted;
                              controller.setVolume(isMuted ? 0 : 1);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(32),
                child: CustomCircleLoading(),
              ),
          ],
        ),
      ),
    );
  }
}
