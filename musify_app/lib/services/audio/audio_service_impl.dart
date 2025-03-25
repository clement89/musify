import 'package:just_audio/just_audio.dart';
import 'audio_service.dart';

class AudioServiceImpl implements AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> play(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      throw Exception('Audio playback failed: $e');
    }
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  @override
  Future<bool> isPlaying() async {
    return _audioPlayer.playing;
  }
}
