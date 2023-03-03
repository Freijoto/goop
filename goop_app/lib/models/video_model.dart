class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String description;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
  });

  factory VideoModel.fromMap(Map<String, dynamic> snippet) {
    return VideoModel(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      description: snippet['description'],
    );
  }
}
