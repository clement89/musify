import 'package:musify_app/modules/songs/domain/entities/song.dart';

class SongModel extends Song {
  const SongModel({
    required super.id,
    required super.title,
    required super.artist,
    required super.album,
    required super.albumUrl,
    required super.songUrl,
    required super.previewUrl,
    required super.category,
    required super.releaseDate,
    required super.price,
    required super.rights,
  });

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map["id"]?["attributes"]?["im:id"] ?? '',
      title: map["im:name"]?["label"] ?? '',
      artist: map["im:artist"]?["label"] ?? '',
      album: map["im:collection"]?["im:name"]?["label"] ?? '',
      albumUrl: (map["im:image"] as List<dynamic>?)?.lastOrNull?["label"] ?? '',
      songUrl: map["id"]?["label"] ?? '',
      previewUrl: _extractPreviewUrl(map) ?? "",
      category: map["category"]?["attributes"]?["label"] ?? '',
      releaseDate: map["im:releaseDate"]?["attributes"]?["label"] ?? '',
      price: map["im:price"]?["label"] ?? '',
      rights: map["rights"]?["label"] ?? '',
    );
  }

  /// Factory method to handle cached JSON data
  factory SongModel.fromMapCache(Map<String, dynamic> map) {
    return SongModel(
      id: map["id"] ?? '',
      title: map["title"] ?? '',
      artist: map["artist"] ?? '',
      album: map["album"] ?? '',
      albumUrl: map["albumUrl"] ?? '',
      songUrl: map["songUrl"] ?? '',
      previewUrl: map["previewUrl"] ?? '',
      category: map["category"] ?? '',
      releaseDate: map["releaseDate"] ?? '',
      price: map["price"] ?? '',
      rights: map["rights"] ?? '',
    );
  }

  /// Nullable factory method to safely handle parsing failures
  static SongModel? tryFromMap(Map<String, dynamic> map) {
    try {
      return SongModel.fromMap(map);
    } catch (e) {
      return null;
    }
  }

  static String? _extractPreviewUrl(Map<String, dynamic> map) {
    return (map["link"] as List<dynamic>?)?.firstWhere(
      (link) => link["attributes"]["rel"] == "enclosure",
      orElse: () => null,
    )?["attributes"]["href"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "artist": artist,
      "album": album,
      "albumUrl": albumUrl,
      "songUrl": songUrl,
      "previewUrl": previewUrl,
      "category": category,
      "releaseDate": releaseDate,
      "price": price,
      "rights": rights,
    };
  }
}
