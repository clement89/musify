import 'package:musify_app/modules/cart/domain/entities/cart.dart';

abstract class CartRepository {
  /// Fetches the list of songs in the cart.
  ///
  /// - Checks if cached data exists, returning it if available.
  /// - If no cache is found, it fetches from the API and caches the result.
  /// - If both sources fail, an `AppException` is thrown.
  Future<Cart> fetchCartItemsRepo();

  /// Updates the cart with the provided [cart] data.
  void updateCartRepo({required Cart cart});
}
