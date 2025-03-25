import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musify_app/core/di/injection_container.dart';
import 'package:musify_app/modules/songs/presentation/screens/cart_screen.dart';
import 'package:musify_app/modules/songs/presentation/screens/song_details_screen.dart';
import 'package:musify_app/modules/songs/presentation/screens/songs_screen.dart';
import 'package:musify_app/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:musify_app/modules/splash/presentation/splash_screen.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';
import 'package:musify_app/services/storage/storage_service.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return _registerBlocView(
          view: const SplashScreen(),
          bloc: SplashBloc(
            navigationService: locator<NavigationService>(),
            storageService: locator<StorageService>(),
          )..add(SplashStarted()),
          settings: settings,
        );
      case AppRoutes.songsScreen:
        return _route(
          child: const SongsScreen(),
        );
      case AppRoutes.songDetailsScreen:
        return _route(
          child: const SongDetailsScreen(),
        );
      case AppRoutes.cartScreen:
        return _route(
          child: const CartScreen(),
        );
      default:
        return _route(
          child: Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }

  //**********************************************************************/

  static MaterialPageRoute _route({required Widget child}) {
    return MaterialPageRoute(builder: (context) => child);
  }

  static MaterialPageRoute _registerBlocView<T extends Bloc>({
    required Widget view,
    required T bloc,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => BlocProvider<T>(
        create: (context) => bloc,
        child: view,
      ),
    );
  }
}
