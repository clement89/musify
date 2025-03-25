import 'package:musify_app/modules/songs/data/datasources/song_data_source.dart';
import 'package:musify_app/modules/songs/data/models/feed_model.dart';
import 'package:musify_app/services/api/api_service.dart';

import 'package:musify_app/services/api/constants.dart';

class SongRemoteDataSource implements SongDataSource {
  final ApiService _apiService;

  SongRemoteDataSource(this._apiService);

  @override
  Future<FeedModel?> fetchFeed() async {
    try {
      final response = await _apiService.get(ApiConstants.topSongsEndpoint);
      return FeedModel.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
