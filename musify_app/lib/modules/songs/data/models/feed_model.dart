import 'package:musify_app/modules/songs/domain/entities/feed.dart';

import 'song_model.dart';

class FeedModel extends Feed {
  const FeedModel({
    super.authorName,
    super.authorUri,
    super.songs,
    super.updated,
    super.rights,
    super.title,
    super.iconUrl,
    super.id,
    super.link,
  });

  factory FeedModel.fromMap(Map<String, dynamic> map) {
    return FeedModel(
      authorName: map["feed"]?["author"]?["name"]?["label"],
      authorUri: map["feed"]?["author"]?["uri"]?["label"],
      songs: (map["feed"]?["entry"] as List<dynamic>?)
          ?.map((e) => SongModel.tryFromMap(e))
          .whereType<SongModel>() // Only keep non-null parsed songs
          .toList(),
      updated: map["feed"]?["updated"]?["label"],
      rights: map["feed"]?["rights"]?["label"],
      title: map["feed"]?["title"]?["label"],
      iconUrl: map["feed"]?["icon"]?["label"],
      id: map["feed"]?["id"]?["label"],
      link: (map["feed"]?["link"] as List<dynamic>?)?.firstWhere(
        (link) => link["attributes"]["rel"] == "self",
        orElse: () => null,
      )?["attributes"]["href"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "authorName": authorName,
      "authorUri": authorUri,
      "songs": songs?.map((song) => (song as SongModel).toMap()).toList(),
      "updated": updated,
      "rights": rights,
      "title": title,
      "iconUrl": iconUrl,
      "id": id,
      "link": link,
    };
  }
}
