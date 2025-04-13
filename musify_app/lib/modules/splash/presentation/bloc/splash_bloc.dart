import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:musify_app/services/storage/storage_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final StorageService storageService;
  SplashBloc({
    required this.storageService,
  }) : super(SplashState.initial()) {
    on<SplashEvent>((event, emit) {});
    on<SplashStarted>(_splashStarted);
  }

  Future<void> _splashStarted(
      SplashStarted event, Emitter<SplashState> emit) async {
    await Future.delayed(
        const Duration(
          milliseconds: 1000,
        ), () {
      emit(state.copyWith(loadComplete: true));
    });
  }
}
