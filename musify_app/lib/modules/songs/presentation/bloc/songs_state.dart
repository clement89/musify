part of 'songs_bloc.dart';

@immutable
class SongsState extends Equatable {
  final Status status;
  final Feed? feed;
  final AppException? error;
  final Song? currentSong;

  const SongsState({
    required this.feed,
    required this.status,
    required this.error,
    required this.currentSong,
  });

  @override
  List<Object> get props => [status];

// Factory method for the initial state
  factory SongsState.initial() {
    return const SongsState(
      status: Status.progress,
      feed: null,
      error: null,
      currentSong: null,
    );
  }

  SongsState copyWith({
    Status? status,
    Feed? feed,
    AppException? error,
    Song? currentSong,
  }) {
    return SongsState(
      status: status ?? this.status,
      feed: feed ?? this.feed,
      error: error ?? this.error,
      currentSong: currentSong ?? this.currentSong,
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
