class PlaylistItemModel {
  String id;

  PlaylistItemModel([this.id = '']);

  factory PlaylistItemModel.fromMap(Map<String, dynamic> map) {
    return PlaylistItemModel(
      map['contentDetails']['videoId'],
    );
  }
}
