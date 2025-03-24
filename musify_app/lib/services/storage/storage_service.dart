import 'package:musify_app/core/models/song.dart';

abstract class StorageService {
  /// Stores the fetched list of songs locally
  Future<void> saveSongs(List<Song> songs);

  /// Retrieves stored songs from local storage
  Future<List<Song>> getSongs();

  /// Adds a song to the cart
  Future<void> addToCart(Song song);

  /// Removes a song from the cart
  Future<void> removeFromCart(String songId);

  /// Retrieves all cart items
  Future<List<Song>> getCartItems();

  /// Clears the cart (on checkout)
  Future<void> clearCart();
}
