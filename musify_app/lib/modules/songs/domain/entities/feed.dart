import 'song.dart'; // Domain layer Song entity

class Feed {
  final String? authorName;
  final String? authorUri;
  final List<Song>? songs;
  final String? updated;
  final String? rights;
  final String? title;
  final String? iconUrl;
  final String? id;
  final String? link;

  const Feed({
    this.authorName,
    this.authorUri,
    this.songs,
    this.updated,
    this.rights,
    this.title,
    this.iconUrl,
    this.id,
    this.link,
  });
}
