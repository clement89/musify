class Song {
  final String id;
  final String title;
  final String artist;
  final String albumImage;
  final String previewUrl; // For playing the song (if available)

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumImage,
    required this.previewUrl,
  });

  /// Converts a Map to a Song object
  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as String,
      title: map['title'] as String,
      artist: map['artist'] as String? ?? "Unknown Artist",
      albumImage: map['albumImage'] as String,
      previewUrl: map['previewUrl'] as String? ?? "",
    );
  }

  /// Converts a Song object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'albumImage': albumImage,
      'previewUrl': previewUrl,
    };
  }
}
