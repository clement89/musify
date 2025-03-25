import 'package:musify_app/modules/songs/domain/entities/feed.dart';

abstract class SongRepository {
  /// Fetches the song feed.
  ///
  /// - Checks if cached data exists, returning it if available.
  /// - If no cache is found, it fetches from the API and caches the result.
  /// - If both sources fail, an `AppException` is thrown.
  Future<Feed> fetchFeed();
}
