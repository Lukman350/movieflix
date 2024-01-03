import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieflix/models/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayTrailer extends StatelessWidget {
  const PlayTrailer({super.key});

  @override
  Widget build(BuildContext context) {
    final Video videoData = ModalRoute.of(context)!.settings.arguments as Video;

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // show status bar when exiting fullscreen
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
      },
      player: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoData.key,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color.fromARGB(255, 17, 14, 71),
        progressColors: const ProgressBarColors(
          playedColor: Color.fromARGB(255, 17, 14, 71),
          handleColor: Color.fromARGB(255, 17, 14, 71),
        ),
        onReady: () {},
        onEnded: (data) {
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          );

          Navigator.pop(context);
        },
        topActions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
              );

              Navigator.pop(context);
            },
          ),
          title: const Text(
            'MovieFlix',
            style: TextStyle(
                color: Color.fromARGB(255, 17, 14, 71),
                fontSize: 24,
                fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: player,
            ),
          ],
        ),
      ),
    );
  }
}
