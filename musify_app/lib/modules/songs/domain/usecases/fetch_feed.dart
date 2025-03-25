import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/repositories/song_repository.dart';

class FetchFeed {
  final SongRepository _repository;

  FetchFeed(this._repository);

  Future<Feed> call() async {
    try {
      return await _repository.fetchFeed();
    } catch (e) {
      throw AppException.unexpected();
    }
  }
}
