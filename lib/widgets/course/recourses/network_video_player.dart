import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const NetworkVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late FlickManager flickManager;
  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      ),
      autoPlay: false,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            FlickVideoPlayer(
              flickManager: flickManager,
              preferredDeviceOrientationFullscreen: const [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
            ),
            if (!isVideoPlaying)
              Center(
                child: IconButton(
                  icon: Icon(Icons.play_arrow),
                  iconSize: 64.0,
                  onPressed: () {
                    setState(() {
                      isVideoPlaying = true;
                    });
                    flickManager.flickControlManager?.togglePlay();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
