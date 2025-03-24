import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:musify_app/core/di/injection_container.dart';
import 'package:musify_app/core/models/song.dart';
import 'package:musify_app/services/logs/logs_service.dart';
import 'package:musify_app/services/storage/storage_service.dart';

const String kSongsKey = 'cached_songs';
const String kCartKey = 'cart_items';

class StorageServiceImpl implements StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final log = locator<LogService>();

  Future<void> _writeData(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      log.logError("Error writing data:", error: e);
    }
  }

  Future<String?> _readData(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      log.logError("Error reading data:", error: e);
      return null;
    }
  }

  Future<void> _deleteData(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      log.logError("Error deleting data:", error: e);
    }
  }

  /// Stores the fetched list of songs locally
  @override
  Future<void> saveSongs(List<Song> songs) async {
    String songsJson = jsonEncode(songs.map((song) => song.toMap()).toList());
    await _writeData(kSongsKey, songsJson);
  }

  /// Retrieves stored songs from local storage
  @override
  Future<List<Song>> getSongs() async {
    String? songsJson = await _readData(kSongsKey);
    if (songsJson == null) return [];
    List<dynamic> songList = jsonDecode(songsJson);
    return songList.map((song) => Song.fromMap(song)).toList();
  }

  /// Adds a song to the cart
  @override
  Future<void> addToCart(Song song) async {
    List<Song> cartItems = await getCartItems();
    cartItems.add(song);
    String cartJson =
        jsonEncode(cartItems.map((song) => song.toMap()).toList());
    await _writeData(kCartKey, cartJson);
  }

  /// Removes a song from the cart
  @override
  Future<void> removeFromCart(String songId) async {
    List<Song> cartItems = await getCartItems();
    cartItems.removeWhere((song) => song.id == songId);
    String cartJson =
        jsonEncode(cartItems.map((song) => song.toMap()).toList());
    await _writeData(kCartKey, cartJson);
  }

  /// Retrieves all cart items
  @override
  Future<List<Song>> getCartItems() async {
    String? cartJson = await _readData(kCartKey);
    if (cartJson == null) return [];
    List<dynamic> cartList = jsonDecode(cartJson);
    return cartList.map((song) => Song.fromMap(song)).toList();
  }

  /// Clears the cart after checkout
  @override
  Future<void> clearCart() async {
    await _deleteData(kCartKey);
  }
}
