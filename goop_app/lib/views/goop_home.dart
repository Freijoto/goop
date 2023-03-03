import 'package:flutter/material.dart';
import 'package:goop_app/models/playlis_item_model.dart';
import 'package:goop_app/repository/goop_repository.dart';
import 'package:goop_app/models/channel_model.dart';
import 'package:goop_app/utilities/goop_constants.dart';
import 'package:goop_app/models/video_model.dart';
import 'package:goop_app/views/goop_video_list_view.dart';

class GoopHome extends StatefulWidget {
  const GoopHome({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GoopHomeState createState() => _GoopHomeState();
}

class _GoopHomeState extends State<GoopHome> {
  static GoopRepository repository = GoopRepository.instance;
  ChannelModel _channel = ChannelModel();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initVideos();
  }

  _initVideos() async {
    ChannelModel channelInfo =
        await repository.fetchChannel(channelId: GoopConfig.channelId);

    setState(() {
      _channel = channelInfo;
    });
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<VideoModel> moreVideos = await repository.fetchVideosFromPlaylist(
        playlistId: _channel.uploadPlaylistId);
    List<VideoModel> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            GoopAssets.logo,
          ),
          centerTitle: true,
          backgroundColor: GoopColors.barColor,
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollDetails) {
            if (!_isLoading &&
                _channel.videos.length != int.parse(_channel.videoCount) &&
                scrollDetails.metrics.pixels ==
                    scrollDetails.metrics.maxScrollExtent) {
              _loadMoreVideos();
            }
            return false;
          },
          child: GoopVideoListView(channel: _channel),
        ),
      ),
    );
  }
}
