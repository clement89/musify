import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/domain/usecases/songs_usecase.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final SongsUseCase useCase;

  SongsBloc({required this.useCase}) : super(SongsState.initial()) {
    on<FetchSongs>(_onFetchSongs);
    on<RefreshSongs>(_onRefreshSongs);
    on<PlaySong>(_onPlaySong);
    on<SelectSong>(_onSelectSong);
  }

  Future<void> _onFetchSongs(FetchSongs event, Emitter<SongsState> emit) async {
    emit(state.copyWith(status: Status.progress));

    try {
      final result = await useCase.fetchFeedsFromRepo();

      emit(state.copyWith(status: Status.loaded, feed: result));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, error: e));
    } catch (_) {
      emit(
          state.copyWith(status: Status.error, error: AppException.unexpected));
    }
  }

  Future<void> _onRefreshSongs(
      RefreshSongs event, Emitter<SongsState> emit) async {
    emit(state.copyWith(status: Status.progress));

    try {
      final result = await useCase.fetchFeedsFromRepo();
      emit(state.copyWith(status: Status.loaded, feed: result));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, error: e));
    } catch (_) {
      emit(
          state.copyWith(status: Status.error, error: AppException.unexpected));
    }
  }

  /// Handle playing a song
  Future<void> _onPlaySong(PlaySong event, Emitter<SongsState> emit) async {
    try {
      if (state.status == Status.playing && state.currentSong == event.song) {
        await useCase.pauseSong();
        emit(state.copyWith(status: Status.paused));
      } else {
        await useCase.stopSong();
        useCase.playSong(event.song);
        emit(state.copyWith(status: Status.playing, currentSong: event.song));
      }
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, error: e));
    }
  }

  void _onSelectSong(SelectSong event, Emitter<SongsState> emit) {
    emit(state.copyWith(selectedSong: event.song));
  }
}
