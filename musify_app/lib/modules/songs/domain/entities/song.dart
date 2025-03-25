import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String albumUrl;
  final String songUrl;
  final String previewUrl;
  final String category;
  final String releaseDate;
  final String price;
  final String rights;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.albumUrl,
    required this.songUrl,
    required this.previewUrl,
    required this.category,
    required this.releaseDate,
    required this.price,
    required this.rights,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        artist,
        album,
        albumUrl,
        songUrl,
        previewUrl,
        category,
        releaseDate,
        price,
        rights,
      ];
}
