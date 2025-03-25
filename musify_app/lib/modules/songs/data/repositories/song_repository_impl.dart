import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/data/datasources/song_local_data_source.dart';
import 'package:musify_app/modules/songs/data/datasources/song_remote_data_source.dart';
import 'package:musify_app/modules/songs/data/models/feed_model.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/repositories/song_repository.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource _remoteDataSource;
  final SongLocalDataSource _localDataSource;

  SongRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Feed> fetchFeed() async {
    try {
      // Step 1: Try to get cached data first
      final FeedModel? cachedFeed = await _localDataSource.fetchFeed();
      if (cachedFeed != null) {
        return cachedFeed; // Return cached data
      }

      // Step 2: No cached data? Fetch from API
      final FeedModel? remoteFeed = await _remoteDataSource.fetchFeed();
      if (remoteFeed != null) {
        await _localDataSource.cacheFeed(remoteFeed); // Cache for later use
        return remoteFeed;
      }

      // Step 3: If API also returns null, throw an exception
      throw AppException.notFound;
    } catch (e) {
      // Step 4: Propagate exception to the domain layer
      rethrow;
    }
  }
}
