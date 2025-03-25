part of 'songs_bloc.dart';

@immutable
class SongsState extends Equatable {
  final Status status;
  final Feed? feed;
  final AppException? error;
  final Song? currentSong;
  final Song? selectedSong;
  final List<Song> cart;

  const SongsState({
    required this.feed,
    required this.status,
    required this.error,
    required this.currentSong,
    required this.selectedSong,
    required this.cart,
  });

  @override
  List<Object?> get props =>
      [status, feed, error, currentSong, selectedSong, cart];

// Factory method for the initial state
  factory SongsState.initial() {
    return const SongsState(
      status: Status.progress,
      feed: null,
      error: null,
      currentSong: null,
      selectedSong: null,
      cart: [],
    );
  }

  SongsState copyWith({
    Status? status,
    Feed? feed,
    AppException? error,
    Song? currentSong,
    Song? selectedSong,
    List<Song>? cart,
  }) {
    return SongsState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      error: error ?? this.error,
      currentSong: currentSong ?? this.currentSong,
      selectedSong: selectedSong ?? this.selectedSong,
      cart: cart ?? this.cart,
    );
  }
}

enum Status {
  progress,
  error,
  loaded,
  playing,
  paused,
}
