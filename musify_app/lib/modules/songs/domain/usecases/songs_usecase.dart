import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/domain/repositories/song_repository.dart';
import 'package:musify_app/services/audio/audio_service.dart';

class SongsUseCase {
  final SongRepository _repository;
  final AudioService _audioService;

  SongsUseCase(this._repository, this._audioService);

  Future<Feed> fetchFeedsFromRepo() async {
    try {
      return await _repository.fetchFeed();
    } catch (e) {
      throw AppException.unexpected();
    }
  }

  /// Play the selected song
  Future<void> playSong(Song song) async {
    try {
      await _audioService.play(song.previewUrl);
    } catch (e) {
      throw AppException.unexpected();
    }
  }

  /// Pause the currently playing song
  Future<void> pauseSong() async {
    try {
      await _audioService.pause();
    } catch (e) {
      throw AppException.unexpected();
    }
  }
}
