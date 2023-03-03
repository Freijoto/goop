import 'package:flutter/material.dart';
import 'package:goop_app/models/channel_model.dart';
import 'package:goop_app/views/goop_video_player_view.dart';
import 'package:goop_app/components/goop_list_item_view.dart';
import 'package:goop_app/utilities/goop_constants.dart';

class GoopVideoListView extends StatelessWidget {
  final ChannelModel channel;
  const GoopVideoListView({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              GoopStrings.title,
              style: TextStyle(
                  color: GoopColors.textColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: channel.videos.length,
              itemBuilder: (context, index) {
                return GoopListItemView(video: channel.videos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
