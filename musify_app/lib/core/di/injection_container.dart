import 'package:get_it/get_it.dart';
import 'package:musify_app/services/logs/logs_service.dart';
import 'package:musify_app/services/logs/logs_service_impl.dart';
import 'package:musify_app/services/navigation/navigation_service.dart';
import 'package:musify_app/services/navigation/navigation_service_impl.dart';
import 'package:musify_app/services/storage/storage_service.dart';
import 'package:musify_app/services/storage/storage_service_impl.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  locator
      .registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
  locator.registerLazySingleton<LogService>(() => LogServiceImpl());
}
