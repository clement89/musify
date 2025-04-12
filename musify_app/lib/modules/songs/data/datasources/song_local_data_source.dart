import 'package:flutter/material.dart';
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/songs/data/datasources/song_data_source.dart';
import 'package:musify_app/modules/songs/data/models/feed_model.dart';
import 'package:musify_app/services/storage/storage_service.dart';

class SongLocalDataSource implements SongDataSource {
  final StorageService _storageService;
  static const String _cacheKey = 'cached_feed';

  SongLocalDataSource(this._storageService);

  @override
  Future<FeedModel?> fetchFeed() async {
    try {
      final cachedData = await _storageService.get(_cacheKey);
      if (cachedData != null) {
        return FeedModel.fromMapCache(cachedData);
      }
      return null;
    } catch (e) {
      debugPrint('Error - $e');
      throw AppException.storageError;
    }
  }

  Future<void> cacheFeed(FeedModel feed) async {
    try {
      await _storageService.save(_cacheKey, feed.toMap());
    } catch (e) {
      debugPrint('Error - $e');
      throw AppException.storageError;
    }
  }

  Future<void> clearCache() async {
    try {
      await _storageService.delete(_cacheKey);
    } catch (e) {
      debugPrint('Error - $e');
      throw AppException.storageError;
    }
  }
}
