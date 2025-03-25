import 'package:get_it/get_it.dart';
import 'package:musify_app/modules/songs/data/datasources/song_local_data_source.dart';
import 'package:musify_app/modules/songs/data/datasources/song_remote_data_source.dart';
import 'package:musify_app/modules/songs/data/repositories/song_repository_impl.dart';
import 'package:musify_app/modules/songs/domain/repositories/song_repository.dart';
import 'package:musify_app/modules/songs/domain/usecases/fetch_feed.dart';
import 'package:musify_app/services/api/api_service.dart';
import 'package:musify_app/services/api/api_service_impl.dart';
import 'package:musify_app/services/logs/logs_service.dart';
import 'package:musify_app/services/logs/logs_service_impl.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';
import 'package:musify_app/services/navigation/navigation_service_impl.dart';
import 'package:musify_app/services/storage/storage_service.dart';
import 'package:musify_app/services/storage/storage_service_impl.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Core Services
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  locator
      .registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
  locator.registerLazySingleton<LogService>(() => LogServiceImpl());

  // Data Sources
  locator.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSource(locator<ApiService>()));
  locator.registerLazySingleton<SongLocalDataSource>(
      () => SongLocalDataSource(locator<StorageService>()));

  // Repository
  locator.registerLazySingleton<SongRepository>(() => SongRepositoryImpl(
      locator<SongRemoteDataSource>(), locator<SongLocalDataSource>()));

  // Use Cases
  locator.registerLazySingleton<FetchFeed>(
      () => FetchFeed(locator<SongRepository>()));
}
