import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';
import 'package:musify_app/services/storage/storage_service.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final NavigationService navigationService;
  final StorageService storageService;
  SplashBloc({
    required this.navigationService,
    required this.storageService,
  }) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<SplashStarted>(_splashStarted);
  }

  Future<void> _splashStarted(
      SplashStarted event, Emitter<SplashState> emit) async {
    Future.delayed(
        const Duration(
          milliseconds: 1000,
        ), () {
      navigationService.navigateToAndRemoveUntil(
          AppRoutes.welcomeScreen, (p0) => false);
    });
  }
}
