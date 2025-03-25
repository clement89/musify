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

class SelectSong extends SongsEvent {
  final Song song;

  const SelectSong(this.song);

  @override
  List<Object> get props => [song];
}

class AddToCart extends SongsEvent {
  final Song song;
  const AddToCart(this.song);

  @override
  List<Object> get props => [song];
}

// Event to refresh the song list (if needed)
class OpenCart extends SongsEvent {
  const OpenCart();
}

class Clearcart extends SongsEvent {
  const Clearcart();
}
