import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPlayer extends StatefulWidget {
  MyVideoPlayer({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late String videoURL;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize videoURL in initState, where it's safe to access widget properties
    videoURL = "https://www.youtube.com/watch?v=${widget.id}";

    // Initialize the YoutubePlayerController
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
        showLiveFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () => debugPrint("Ready"),
      progressIndicatorColor: Colors.amber[900],
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      aspectRatio: 16 / 10,
    );
  }
}
