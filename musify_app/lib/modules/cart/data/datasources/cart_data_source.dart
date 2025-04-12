import 'package:musify_app/modules/cart/data/models/cart_model.dart';

abstract class CartDataSource {
  /// Fetches the list of songs in the cart.
  Future<CartModel> fetchCartItems();

  /// Add/remove a song to the cart.
  void updatedCart({required CartModel cartModel});
}
