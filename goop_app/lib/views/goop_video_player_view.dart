import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:goop_app/utilities/goop_constants.dart';

class GoopVideoPlayerView extends StatefulWidget {
  final String _videoId;

  const GoopVideoPlayerView({super.key, required String videoId})
      : _videoId = videoId;

  @override
  // ignore: library_private_types_in_public_api
  _GoopVideoPlayerViewState createState() =>
      // ignore: no_logic_in_create_state
      _GoopVideoPlayerViewState(_videoId);
}

class _GoopVideoPlayerViewState extends State<GoopVideoPlayerView> {
  final String _id;
  _GoopVideoPlayerViewState(this._id);
  late YoutubePlayerController _controler;

  @override
  void initState() {
    _controler = YoutubePlayerController(
      initialVideoId: _id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GoopColors.backgroundColor,
      appBar: AppBar(
        title: Image.asset(
          GoopAssets.logo,
        ),
        centerTitle: true,
        backgroundColor: GoopColors.barColor,
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controler,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
