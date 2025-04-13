import 'package:musify_app/modules/cart/presentation/screens/cart_screen.dart';
import 'package:musify_app/modules/songs/presentation/screens/song_details_screen.dart';
import 'package:musify_app/modules/songs/presentation/screens/songs_screen.dart';
import 'package:musify_app/modules/splash/presentation/splash_screen.dart';
import 'package:musify_app/routes/app_routes.dart';
import 'package:musify_app/routes/not_found_screen.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.songsScreen,
      builder: (context, state) => const SongsScreen(),
    ),
    GoRoute(
      path: AppRoutes.songDetailsScreen,
      builder: (context, state) => const SongDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.cartScreen,
      builder: (context, state) => const CartScreen(),
    ),
  ],
  errorBuilder: (context, state) => NotFoundScreen(route: state.uri.toString()),
);
