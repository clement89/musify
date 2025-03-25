import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/domain/entities/feed.dart';
import 'package:musify_app/modules/songs/domain/entities/song.dart';
import 'package:musify_app/modules/songs/domain/usecases/songs_usecase.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';

part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  final SongsUseCase useCase;
  final NavigationService navigationService;

  SongsBloc({required this.useCase, required this.navigationService})
      : super(SongsState.initial()) {
    on<FetchSongs>(_onFetchSongs);
    on<RefreshSongs>(_onRefreshSongs);
    on<PlaySong>(_onPlaySong);
    on<SelectSong>(_onSelectSong);
    on<AddToCart>(_onAddToCart);
    on<OpenCart>(_openCart);
    on<Clearcart>(_clearCart);
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
      if (state.status == Status.playing) {
        await useCase.pauseSong();
        emit(state.copyWith(status: Status.paused));
      } else {
        useCase.playSong(event.song);
        emit(state.copyWith(status: Status.playing, currentSong: event.song));
      }
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, error: e));
    }
  }

  void _onSelectSong(SelectSong event, Emitter<SongsState> emit) {
    emit(state.copyWith(selectedSong: event.song));
    navigationService.navigateToNamed(AppRoutes.songDetailsScreen);
  }

  void _onAddToCart(AddToCart event, Emitter<SongsState> emit) {
    final updatedCart = List<Song>.from(state.cart);

    if (updatedCart.contains(event.song)) {
      updatedCart.remove(event.song);
    } else {
      updatedCart.add(event.song);
    }

    emit(state.copyWith(cart: updatedCart));
  }

  void _openCart(OpenCart event, Emitter<SongsState> emit) {
    navigationService.navigateToNamed(AppRoutes.cartScreen);
  }

  void _clearCart(Clearcart event, Emitter<SongsState> emit) {
    navigationService.back();
    emit(state.copyWith(cart: []));
  }
}
