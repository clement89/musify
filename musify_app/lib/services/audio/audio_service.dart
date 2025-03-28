abstract class AudioService {
  Future<void> play(String url);
  Future<void> pause();
  Future<void> stop();
  Future<bool> isPlaying();
}
