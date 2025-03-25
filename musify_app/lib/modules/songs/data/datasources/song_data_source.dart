import 'package:musify_app/modules/songs/data/models/feed_model.dart';

abstract class SongDataSource {
  /// Fetches the latest songs feed from the remote API.
  Future<FeedModel?> fetchFeed();
}
