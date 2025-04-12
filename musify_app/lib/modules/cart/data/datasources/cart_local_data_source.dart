import 'package:flutter/foundation.dart' show debugPrint;
import 'package:musify_app/core/exceptions/app_exception.dart';
import 'package:musify_app/modules/cart/data/datasources/cart_data_source.dart';
import 'package:musify_app/modules/cart/data/models/cart_model.dart';
import 'package:musify_app/services/storage/storage_service.dart';

class CartLocalDataSource implements CartDataSource {
  final StorageService _storageService;
  static const String _cacheKey = 'cached_cart';

  CartLocalDataSource(this._storageService);

  @override
  Future<CartModel> fetchCartItems() async {
    try {
      final cachedData = await _storageService.get(_cacheKey);
      if (cachedData != null) {
        return CartModel.fromJson(cachedData);
      }
      return const CartModel(items: []);
    } catch (e) {
      debugPrint('Error - $e');
      throw AppException.storageError;
    }
  }

  @override
  void updatedCart({required CartModel cartModel}) {
    // Implementation for updating the cart
    // This could involve adding/removing items based on the CartModel provided
    cacheCart(cartModel);
  }

  /// Caches the cart data.
  Future<void> cacheCart(CartModel cart) async {
    try {
      await _storageService.save(_cacheKey, cart.toJson());
    } catch (e) {
      debugPrint('Error - $e');
      throw AppException.storageError;
    }
  }

  /// Clears the cached cart data.
  Future<void> clearCache() async {
    try {
      await _storageService.delete(_cacheKey);
    } catch (e) {
      debugPrint('Error - $e');
      throw AppException.storageError;
    }
  }
}
