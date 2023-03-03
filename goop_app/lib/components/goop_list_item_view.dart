import 'package:flutter/material.dart';
import 'package:goop_app/utilities/goop_constants.dart';
import 'package:goop_app/models/video_model.dart';
import 'package:goop_app/views/goop_video_player_view.dart';

class GoopListItemView extends StatelessWidget {
  const GoopListItemView({super.key, required this.video});
  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigate(context, video.id);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SizedBox(
                  width: 130,
                  height: 100,
                  child: Center(child: Image.network(video.thumbnailUrl)),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 35,
                    height: 25,
                    color: GoopColors.timerBackground,
                    child: const Center(
                      child: Text(
                        '0:00',
                        style: TextStyle(color: GoopColors.timerText),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                      color: GoopColors.titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    video.description,
                    style: const TextStyle(fontSize: 15),
                    softWrap: false,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _navigate(dynamic context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GoopVideoPlayerView(
          videoId: video.id,
        ),
      ),
    );
  }
}
