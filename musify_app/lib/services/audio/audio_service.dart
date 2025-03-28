import 'package:musify_app/modules/songs/domain/entities/song.dart';

abstract class AudioService {
  Future<void> play(Song song);
  Future<void> pause();
  Future<void> stop();
  Future<bool> isPlaying();
}
