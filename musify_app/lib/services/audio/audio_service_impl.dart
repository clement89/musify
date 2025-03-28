import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'audio_service.dart';

class AudioServiceImpl implements AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> play(Song song) async {
    try {
      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(song.previewUrl),
          tag: MediaItem(
            id: song.id,
            title: song.title,
            artist: song.artist,
            album: song.album,
            artUri: Uri.tryParse(song.albumUrl),
          ),
        ),
      );
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
