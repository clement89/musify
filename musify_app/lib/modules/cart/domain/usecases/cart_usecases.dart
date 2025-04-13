import 'package:musify_app/modules/cart/domain/entities/cart.dart';
import 'package:musify_app/modules/cart/domain/repository/cart_repo.dart';

class CartUsecases {
  final CartRepository _repository;
  CartUsecases(this._repository);

  /// Fetches the cart items from the repository.
  Future<Cart> fetchCartItems() async {
    return await _repository.fetchCartItemsRepo();
  }

  /// Updates the cart with the provided list of songs.
  void updateCart({required Cart cart}) {
    _repository.updateCartRepo(cart: cart);
  }
}
