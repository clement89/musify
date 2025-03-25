part of 'songs_bloc.dart';

@immutable
abstract class SongsEvent extends Equatable {
  const SongsEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch top songs
class FetchSongs extends SongsEvent {
  const FetchSongs();
}

// Event to refresh the song list (if needed)
class RefreshSongs extends SongsEvent {
  const RefreshSongs();
}

/// Play song event
class PlaySong extends SongsEvent {
  final Song song;

  const PlaySong(this.song);

  @override
  List<Object?> get props => [song];
}

/// Pause song event
class PauseSong extends SongsEvent {
  const PauseSong();
}
