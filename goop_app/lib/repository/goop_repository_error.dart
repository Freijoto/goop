import 'dart:io';
import 'package:goop_app/models/channel_model.dart';
import 'package:goop_app/models/playlis_item_model.dart';
import 'package:goop_app/models/video_model.dart';
import 'package:goop_app/utilities/keys.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GoopRepositoryError {
  GoopRepositoryError._instantiate();
  static final GoopRepositoryError instance =
      GoopRepositoryError._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<ChannelModel> fetchChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': apiKey,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      ChannelModel channel = ChannelModel.fromMap(data);
      var listVideosId = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      channel.videos = await fetchVideos(listId: listVideosId);
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<PlaylistItemModel>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'contentDetails',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': apiKey,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videoJson = data['items'];

      List<PlaylistItemModel> listId = [];
      videoJson.forEach(
        (json) => listId.add(
          PlaylistItemModel.fromMap(json),
        ),
      );
      return listId;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<VideoModel>> fetchVideos(
      {required List<PlaylistItemModel> listId}) async {
    List<VideoModel> videos = [];
    listId.forEach((item) async {
      Map<String, String> parameters = {
        'part': 'snippet',
        'id': item.id,
        'key': apiKey,
      };

      Uri uri = Uri.https(
        _baseUrl,
        '/youtube/v3/videos',
        parameters,
      );

      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      print(await http.get(uri, headers: headers));
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> videoJson = data['items'];

        videoJson.forEach(
          (json) => videos.add(
            VideoModel.fromMap(json),
          ),
        );
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    });
    return videos;
  }
}
