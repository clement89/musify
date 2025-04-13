import 'package:get_it/get_it.dart';
import 'package:musify_app/modules/cart/data/datasources/cart_data_source.dart';
import 'package:musify_app/modules/cart/data/datasources/cart_local_data_source.dart';
import 'package:musify_app/modules/cart/data/repository/cart_repo_impl.dart';
import 'package:musify_app/modules/cart/domain/repository/cart_repo.dart';
import 'package:musify_app/modules/cart/domain/usecases/cart_usecases.dart';
import 'package:musify_app/modules/songs/data/datasources/song_local_data_source.dart';
import 'package:musify_app/modules/songs/data/datasources/song_remote_data_source.dart';
import 'package:musify_app/modules/songs/data/repositories/song_repository_impl.dart';
import 'package:musify_app/modules/songs/domain/repositories/song_repository.dart';
import 'package:musify_app/modules/songs/domain/usecases/songs_usecase.dart';
import 'package:musify_app/services/api/api_service.dart';
import 'package:musify_app/services/api/api_service_impl.dart';
import 'package:musify_app/services/audio/audio_service.dart';
import 'package:musify_app/services/audio/audio_service_impl.dart';
import 'package:musify_app/services/logs/logs_service.dart';
import 'package:musify_app/services/logs/logs_service_impl.dart';
import 'package:musify_app/services/storage/storage_service.dart';
import 'package:musify_app/services/storage/storage_service_impl.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Core Services
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  locator.registerLazySingleton<LogService>(() => LogServiceImpl());
  locator.registerLazySingleton<AudioService>(() => AudioServiceImpl());

  // Data Sources
  locator.registerLazySingleton<SongRemoteDataSource>(
      () => SongRemoteDataSource(locator<ApiService>()));
  locator.registerLazySingleton<SongLocalDataSource>(
      () => SongLocalDataSource(locator<StorageService>()));

  locator.registerLazySingleton<CartDataSource>(
      () => CartLocalDataSource(locator<StorageService>()));

  locator.registerLazySingleton<CartRepository>(
      () => CartRepoImpl(locator<CartDataSource>()));

  locator.registerLazySingleton<CartUsecases>(
      () => CartUsecases(locator<CartRepository>()));

  // Repository
  locator.registerLazySingleton<SongRepository>(() => SongRepositoryImpl(
      locator<SongRemoteDataSource>(), locator<SongLocalDataSource>()));

  // Use Cases
  locator.registerLazySingleton<SongsUseCase>(
      () => SongsUseCase(locator<SongRepository>(), locator<AudioService>()));
}
