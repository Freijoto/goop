import 'package:goop_app/models/video_model.dart';

class ChannelModel {
  String id;
  String uploadPlaylistId;
  String videoCount;
  List<VideoModel> videos = [];

  ChannelModel([
    this.id = '',
    this.uploadPlaylistId = '',
    this.videoCount = '',
  ]);

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      map['id'],
      map['contentDetails']['relatedPlaylists']['uploads'],
      map['statistics']['videoCount'],
    );
  }
}
